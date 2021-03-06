//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "DemoAsynchronousViewController.h"

#import <XCDYouTubeKit/XCDYouTubeKit.h>

#import "MPMoviePlayerController+BackgroundPlayback.h"

@implementation DemoAsynchronousViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.apiKeyTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"YouTubeAPIKey"];
}

- (IBAction) play:(id)sender
{
	NSString *apiKey = self.apiKeyTextField.text;
	[[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:@"YouTubeAPIKey"];
	
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
	videoPlayerViewController.backgroundPlaybackEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
	[self.navigationController presentViewController:videoPlayerViewController animated:YES completion:nil];
	
	// https://developers.google.com/youtube/v3/docs/videos/list
	NSURL *mostPopularURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?key=%@&chart=mostPopular&part=id", apiKey]];
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:mostPopularURL] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
	{
		id json = [NSJSONSerialization JSONObjectWithData:data ?: [NSData new] options:0 error:NULL];
		NSString *videoIdentifier = [[[json valueForKeyPath:@"items.id"] firstObject] description];
		videoPlayerViewController.videoIdentifier = videoIdentifier;
		videoPlayerViewController.shouldAutoPlay = YES;
	}];
}

@end
