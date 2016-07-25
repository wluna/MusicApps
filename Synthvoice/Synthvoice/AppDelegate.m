//
//  AppDelegate.m
//  Synthvoice
//
//  Created by Maya Saxena on 2/23/15.
//  Copyright (c) 2015 Maya Saxena. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Initialize the audio controller that handles Core Audio integration
    _audioController = [PdAudioController new];
    if ([_audioController configureAmbientWithSampleRate:44100
                                          numberChannels:2
                                           mixingEnabled:YES] != PdAudioOK){
        NSLog(@"failed to initialize audio controller");
    }
    
    [PdExternals setup];
    
    // Configure the dispatcher to listen for messages from Pure Data. PdBase is initialized by libpd
    PdDispatcher *dispatcher = [PdDispatcher new];
    [PdBase setDelegate:dispatcher];
    
    // Open a patch called demo.pd
    _patch = [PdBase openFile:@"patch.pd"
                         path:[[NSBundle mainBundle] resourcePath]];
    
    // Get the unique $0 for a patch that you open
    int dollarZero = [PdBase dollarZeroForFile:_patch];
    
    if (!_patch){
        NSLog(@"Couldn't open the patch");
    } else {
        _audioController.active = YES;
//        [PdBase sendFloat:(.5) toReceiver:(@"volume")];
       // [PdBase sendFloat:(15) toReceiver:(@"note")];
        [PdBase sendFloat: (2.0) toReceiver: (@"_patch")];
        [PdBase sendFloat: (64) toReceiver: (@"initVolume")];
        [PdBase sendBangToReceiver: (@"initialize")];
        NSLog(@"Opened the patch");
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    _audioController.active = NO;
    [PdBase closeFile:_patch];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     _audioController.active = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
