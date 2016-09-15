//
//  MovieDetailViewController.m
//  FlickrProject
//
//  Created by Tao Xia on 9/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.moiveImage setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342/%@", self.movie[@"poster_path"]]]];
    CGFloat contentWidth = self.movieScroll.bounds.size.width;
    CGFloat contentHeight = self.movieScroll.bounds.size.height*3;
    self.movieScroll.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    CGFloat subviewHeight = 120;
    CGFloat currentViewOffset = 0;
    while (currentViewOffset<contentHeight){
        
        
        
        CGRect frame = CGRectMake(0, currentViewOffset, contentWidth, subviewHeight);

        CGFloat hue = currentViewOffset/contentHeight;
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [[UIColor alloc] initWithHue:hue saturation:1 brightness:1 alpha:1];
        [self.movieScroll addSubview:subview];
        
        currentViewOffset += subviewHeight;
    }
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

@end
