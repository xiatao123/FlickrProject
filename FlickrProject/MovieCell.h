//
//  MovieCell.h
//  FlickrProject
//
//  Created by Tao Xia on 9/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieImageView.h"

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet MovieImageView *movieImage;

@end
