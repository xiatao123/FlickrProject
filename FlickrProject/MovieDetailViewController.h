//
//  MovieDetailViewController.h
//  FlickrProject
//
//  Created by Tao Xia on 9/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieImageView.h"

@interface MovieDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *movie;
@property (weak, nonatomic) IBOutlet MovieImageView *moiveImage;
@property (weak, nonatomic) IBOutlet UIScrollView *movieScroll;

@end
