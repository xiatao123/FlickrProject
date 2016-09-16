//
//  VideoViewController.m
//  FlickrProject
//
//  Created by Tao Xia on 9/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController () <YTPlayerViewDelegate>
@property (nonatomic, strong) NSArray *videos;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.playerView.delegate = self;
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) requestData {
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=%@", self.movie[@"id"], apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    self.videos = responseDictionary[@"results"];
                                                    
                                                    NSDictionary *playerVars = @{
                                                                                 @"playsinline" : @1,
                                                                                 @"autoplay" : @1,
                                                                                 @"showinfo" : @0,
                                                                                 @"rel" : @0,
                                                                                 @"modestbranding" : @1,
                                                                                 };
                                                    
                                                    [self.playerView loadWithVideoId:self.videos[0][@"key"] playerVars:playerVars];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}

- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
    [self.playerView playVideo];
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch(state){
        case kYTPlayerStateEnded:
        case kYTPlayerStatePaused:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

@end
