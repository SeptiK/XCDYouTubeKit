//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

@import AppKit;
@import AVKit;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet AVPlayerView *playerView;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;

@end
