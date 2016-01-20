//
//  SPSoundFileCell.m
//  Sound Player
//
//  Created by Long Le on 1/18/16.
//  Copyright © 2016 Le, Long. All rights reserved.
//

#import "SPSoundFileCell.h"

@implementation SPSoundFileCell

@synthesize descriptionLabel;
@synthesize waveForm;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        //  Initialize the cell's description label. Set x-position and y-position to 0 because we will do it later in this conditional block
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        
        //  Set text color of cell's description label
        descriptionLabel.textColor = [UIColor blackColor];
        
        //  Set font and size of cell's description label
        descriptionLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
        
        //  Center text relative to |descriptionLabel| variable's frame
        descriptionLabel.textAlignment = NSTextAlignmentCenter;

        //  Center |descriptionLabel| to the center of the cell
        [descriptionLabel setCenter: CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.bounds.size.height/2)];

        [self addSubview:descriptionLabel];
        
        waveForm = [[FDWaveformView alloc] init];
    }
    
    return self;
}


@end
