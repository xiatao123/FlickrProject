//
//  VideoViewController.h
//  FlickrProject
//
//  Created by Tao Xia on 9/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "ViewController.h"
#import "YTPlayerView.h"

@interface VideoViewController : ViewController

@property (nonatomic, strong) NSDictionary *movie;
@property (nonatomic, weak) IBOutlet YTPlayerView *playerView;

@end
