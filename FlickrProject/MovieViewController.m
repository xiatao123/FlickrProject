//
//  MovieListViewController.m
//  FlickrProject
//
//  Created by Tao Xia on 9/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "MovieDetailViewController.h"
#import "VideoViewController.h"
#import "MBProgressHUD.h"

@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *warningView;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@end

@implementation MovieViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.endpoint = @"now_playing";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl =[[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    [cell.movieImage setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342/%@", movie[@"poster_path"]]]];
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"detailSegue"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        MovieDetailViewController *mdvc = segue.destinationViewController;
        mdvc.movie = self.movies[indexPath.row];
    }else if([segue.identifier isEqualToString: @"videoSegue"]){
        UIButton *videoButton = sender;        
        UITableViewCell *cell = (UITableViewCell *)[[videoButton superview] superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        VideoViewController *vvc = segue.destinationViewController;
        vvc.movie = self.movies[indexPath.row];
    }
}

- (void) onRefresh {
    [self requestData];
    [self.refreshControl endRefreshing];
    NSLog(@"Finished Refresh");
}

- (void) requestData {
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@", self.endpoint, apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    self.warningView.hidden = true;
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
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
                                                    //NSLog(@"Response: %@", responseDictionary);
                                                    [MBProgressHUD hideHUDForView:self.view animated:true];
                                                    self.movies = responseDictionary[@"results"];
                                                    [self.tableView reloadData];
                                                } else {
                                                    self.warningLabel.text = [NSString stringWithFormat:@"Network Error: %@", error.description];
                                                    self.warningView.hidden = false;
                                                    
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}

@end
