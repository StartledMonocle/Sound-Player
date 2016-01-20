//
//  EASoundManager.m
//  Sound Player
//
//  Created by Long Le on 1/18/16.
//  Copyright © 2016 Le, Long. All rights reserved.
//

#import "EASoundManager.h"

@implementation EASoundManager


@synthesize soundClip;


#pragma mark Singleton Methods

+ (id)sharedManager
{
    static EASoundManager *sharedMyManager = nil;
    @synchronized(self)
    {
        //  Make sure sharedMyManger is initialized only once
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    
    return sharedMyManager;
}

- (id)initWithName:(NSString*)filename
{
    if (self = [super init])
    {
        //  Get resourcePath to the project folder named |Sounds| which contains all of the audio files you wish the app to list and play
        NSString *soundFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sounds"];
        
        //Get URL of sound file passed into the initializer
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", soundFolderPath, filename]];
        
        //Instantiate sound clip
        NSError *error = nil;
        soundClip = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                
        //Play sound
        if (soundClip == nil)
            NSLog(@"Error: %@", [error localizedDescription]);
        else
            [soundClip play];
    }
    
    return self;
}

@end
