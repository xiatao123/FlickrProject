//
//  MovieDetailViewController.m
//  FlickrProject
//
//  Created by Tao Xia on 9/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieLikes;
@property (weak, nonatomic) IBOutlet UILabel *movieOverview;
@property (weak, nonatomic) IBOutlet UILabel *movieDate;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.moiveImage setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342/%@", self.movie[@"poster_path"]]]];
    self.movieTitle.text = self.movie[@"title"];
    self.movieDate.text = self.movie[@"release_date"];
    self.movieLikes.text = [NSString stringWithFormat:@"%@%%", self.movie[@"popularity"]];
    self.movieOverview.text = self.movie[@"overview"];
    self.movieOverview.numberOfLines = 0;
    [self.movieOverview sizeToFit];
    CGRect newFrame = self.movieOverview.frame;
    CGFloat newHeight = newFrame.size.height;  //to get the width of the label
    
    CGFloat contentWidth = self.movieScroll.bounds.size.width;
    CGFloat contentHeight = self.movieScroll.bounds.size.height+newHeight;
    self.movieScroll.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    CGFloat subviewHeight = 100+newHeight;
    CGFloat currentViewOffset = 420;
    
    CGRect frame = CGRectMake(0, currentViewOffset, contentWidth, subviewHeight);

    self.detailView.frame = frame;
    [self.movieScroll addSubview:self.detailView];
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
