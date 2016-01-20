//
//  EASoundManager.h
//  Sound Player
//
//  Created by Long Le on 1/18/16.
//  Copyright © 2016 Le, Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface EASoundManager : NSObject


/**
 @brief sound clip played when designated initializer is called
 */
@property AVAudioPlayer *soundClip;

/** 
 @brief Defines static variable |sharedMyManager| and makes sure it has been initialized only once
 @author Long Le
 */
+ (id)sharedManager;

/**
 @brief Desingated initializer
 @discussion If subclassing EASoundManager be sure to include |self = [super initWithFrame:theFrame];| in the subclasses's designated initializer'
 @author Long Le
 
 @param filename the sound clip to be played. filename is full filename along with filename extension example: boo.wav
 */
- (id)initWithName:(NSString*)filename;

@end
