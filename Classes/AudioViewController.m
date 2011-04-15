//
//  AudioViewController.m
//  FastPdfKit Sample
//
//  Created by Mac Book Pro on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AudioViewController.h"


@implementation AudioViewController

@synthesize volumeControl;
@synthesize isLocal;
@synthesize url;
@synthesize audioPlayer;
@synthesize docVc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil audioFilePath:(NSString *)_audioFilePath isLocal:(BOOL)_isLocal{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		isLocal = _isLocal;
		if (isLocal) {
			url = [NSURL fileURLWithPath:_audioFilePath];
		}else {
			url = [NSURL URLWithString:_audioFilePath];

		}

				
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	NSError *error;
	if (isLocal) {
		audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	}else {
		NSData *audioData = [[NSData alloc] initWithContentsOfURL:url];
		audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
	}

	
	if (error)
	{
		NSLog(@"Error in audioPlayer: %@", 
			  [error localizedDescription]);
	} else {
		[audioPlayer setDelegate:self];
		[audioPlayer prepareToPlay];
        [audioPlayer play];
	}
	
}


-(void)playAudio{
    [audioPlayer play];
}

-(void)stopAudio{
    [audioPlayer stop];
}

-(void)adjustVolume{
    if (audioPlayer != nil)
    {
		audioPlayer.volume = volumeControl.value;
    }
}

-(void)closeController{
	docVc.visibleMultimedia=NO;
    [audioPlayer stop];
    [[self view] removeFromSuperview];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
	docVc.visibleMultimedia=NO;
	[[self view] removeFromSuperview];
	
}
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
	
}
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
	
}
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
	
}

- (void)dealloc{
	[audioPlayer release];
    [volumeControl release];
    [super dealloc];
	
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	audioPlayer = nil;
    volumeControl = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
