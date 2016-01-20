//
//  SPViewController.h
//  Sound Player
//
//  Created by Long Le on 1/18/16.
//  Copyright © 2016 Le, Long. All rights reserved.
//

//define preprocessors here
#define NAV_BAR_HEIGHT  55


#import <UIKit/UIKit.h>
#import "SPSoundFileCell.h"
#import "EASoundManager.h"

@interface SPViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

/**
 @brief tableview to be displayed on root view
 */
@property UITableView *tableView;

/**
 @brief array of NSString variables named after each file in the project's |Sounds| folder
 */
@property NSMutableArray *soundFilenamesArray;


/**
 @brief adds navigation bar to root view
 @author Long Le
 */
- (void)addNavBar;

/**
 @brief loads filesnames of all the files in the projecto's |Sounds| folder and places them into |soundsFilesnamesArray|
 @author Long Le
 */
- (void)loadSoundFilenamesArray;


@end
