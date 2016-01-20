//
//  SPViewController.m
//  Sound Player
//
//  Created by Long Le on 1/18/16.
//  Copyright © 2016 Le, Long. All rights reserved.
//

#import "SPViewController.h"

@implementation SPViewController
{
}

@synthesize tableView;
@synthesize soundFilenamesArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  Initialize |soundFilenamesArray| so it can be used
    soundFilenamesArray = [[NSMutableArray alloc] init];

    //  loads filesnames of all the files in the projecto's |Sounds| folder and places them into |soundsFilesnamesArray|
    [self loadSoundFilenamesArray];
    
    // init table view
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    //  set delegate and datasource, otherwise table will show up empty
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //  Set the color of the view behind the table view. shows when you scroll beyond the table view's bounds
    tableView.backgroundColor = [UIColor lightGrayColor];
    
    // add to view
    [self.view addSubview:tableView];
    
    //  add navigation bar to root view
    [self addNavBar];
    
    //  Shift tableview down to start just below navBar so that navBar does not cover any part of the table view when it first loads
    [tableView setContentInset:UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0)];
}

#pragma mark - layout View UI
- (void)addNavBar
{
    //  Initialize |navBar| and set its position, width, and height
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, NAV_BAR_HEIGHT)];
    //  Add |navBar| to view
    [self.view addSubview:navBar];
    
    //  Add title to |navBar|
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"Sound Player"];
   
    //  Pushes the title to the navbar. Necessary because UINavigationBar is simply a view in this case. Pusing the title to navBar would not be necessary if this view was a child of a UINavigationController
    [navBar pushNavigationItem:item animated:NO];
    
    //  Set the text of the title to "Sound Player"
    navBar.topItem.title = @"Sound Player";
}

#pragma mark - load sounds files

- (void)loadSoundFilenamesArray
{
    NSError *error = nil;
    
    //  Get the path of the project folder where all of the sound files you wish to be displayed and played are locatd. Set stringByAppendingPathComponent: argument to a string whose text is the name of the project folder where all of the sound files are located. In this case that project folder is named "Sounds"
    NSString *soundFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sounds"];
    
    //  Create array of strings whose text is named after each sound file in the project folder |Sounds|
    NSArray  *soundFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:soundFolderPath error:&error];
    
    //  add all of the contents of |soundFiles| array to our class's instance variable array |soundFilenamesArray| so that we can use it outside of this method
    [soundFilenamesArray addObjectsFromArray:soundFiles];
}

#pragma mark - UITableViewDataSource

// number of row in the section. Set to 1 so that we just have a single continuous list view of filenames
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [soundFilenamesArray count];
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SoundFileCell";
    
    //  create cell
    SPSoundFileCell *cell = [[SPSoundFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    //  Get text of the filename corresponding with this cell's row number. This includes the full filename and filename extension
    NSString *filenameWithExtension = [soundFilenamesArray objectAtIndex:indexPath.row];
    //  Get resourcePath to the project folder named |Sounds| which contains all of the audio files you wish the app to list and play
    NSString *soundFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sounds"];
    //  Get URL of sound file passed into the initializer
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", soundFolderPath, filenameWithExtension]];
    
    //  Reset cell
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //  Pass the location of the sound file corresponding with this cell to |waveForm| in order to creat the unique visualization for this cell
    cell.waveForm.audioURL = url;
    //  Resize the |waveForm| view to correspond with the size of the cell
    [cell.waveForm setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, cell.frame.size.height)];
    //  Add waveForm view to current cell
    [cell addSubview:cell.waveForm];

    
    //  Get the text of the name of the file located at this cell's row number within |soundFilesnamesArray|
    NSString *filenameWithoutExtension = [[[soundFilenamesArray objectAtIndex:indexPath.row] lastPathComponent] stringByDeletingPathExtension];
    
    //  Set the text of the label of the cell to that of the filename corresponding with this cell, omitting the file extension name for visual clarity
    cell.descriptionLabel.text = filenameWithoutExtension;

    return cell;
}

#pragma mark - UITableViewDelegate
// when the user taps on the row they should hear the sound associated with the filename written in the cell they tapped on
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Get text of the filename corresponding with this cell's row number. This includes the full filename and filename extension
    NSString *soundFilename = [soundFilenamesArray objectAtIndex:indexPath.row];
    
    //  Play sound file associated with row selected
    EASoundManager *soundManager = [EASoundManager sharedManager];
    
    //  initialize |soundManager| if it's not already. this plays the sound file associated with the cell the user tapped on.
    //  adding (void) to silence warning about the initializer returning a result we don't need. appropriate in this case since we are working with a singleton we only want to be initialized only once.
    (void)[soundManager initWithName: soundFilename];
    
    //Get a reference to the selected cell
    SPSoundFileCell *selectedCell = [theTableView cellForRowAtIndexPath:indexPath];
    
    //Reset the cell's wave form visualization playback progress
    selectedCell.waveForm.progressSamples = 0;
    
    //Play the cell's wave form visualization playback progress animation
    [UIView animateWithDuration:soundManager.soundClip.duration animations:^{
        selectedCell.waveForm.progressSamples = selectedCell.waveForm.totalSamples;
    }];
}

@end
