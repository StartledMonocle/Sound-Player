//
//  SPSoundFileCell.h
//  Sound Player
//
//  Created by Long Le on 1/18/16.
//  Copyright © 2016 Le, Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDWaveformView.h"

@interface SPSoundFileCell : UITableViewCell

/**
 @brief label of text displayed in the center of the cell
 */
@property (nonatomic, strong) UILabel *descriptionLabel;

/**
 @brief method from open source framework called |FDWaveformView|
 @discussion Used to draw the visualized waveform of each soundclip. The visualization is placed within the cell for which each sound clip belongs to and animates as the sound is played. FDWaveformView is a subclass of UIView. In this |Sound Player| project FDWaveformView is initialized in SPViewController, and added as a view to each cell. The unique visualization of the wave form corresponds to the attributes of each sound file. This visualization is created by passing any audio file located in the |Sounds| folder in this project into the appropriate methods for |FDWaveformView|. 
     Example usage:
         NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
         NSString *filePath = [thisBundle pathForResource:@"Submarine" ofType:@"aiff"];
         NSURL *url = [NSURL fileURLWithPath:filePath];
         self.waveform.audioURL = url;
 @author William Entriken
*/
@property FDWaveformView *waveForm;

/**
 @brief Desingated initializer
 @author Long Le
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
