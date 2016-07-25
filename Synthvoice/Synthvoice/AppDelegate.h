//
//  AppDelegate.h
//  Synthvoice
//
//  Created by Maya Saxena on 2/23/15.
//  Copyright (c) 2015 Maya Saxena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdAudioController.h"
#import "PdDispatcher.h"
#import "PdExternals.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) PdAudioController *audioController;
@property void *patch;

@end

