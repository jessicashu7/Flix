//
//  MoviesViewController.m
//  Flix
//
//  Created by Jessica Shu on 6/27/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailCellViewController.h"
#import "SVProgressHUD.h"
#import "Movie.h"
#import "MovieAPIManager.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    NSLog(@"loading");

    // Do any additional setup after loading the view.
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    [self fetchMovies];
    [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
           [SVProgressHUD dismiss];

        });
    
    });
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies)forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

}

- (void)fetchMovies {
    MovieAPIManager *manager = [MovieAPIManager new];
    [manager fetchNowPlaying:^(NSArray *movies, NSError *error) {
        
        if (error) {
            [self noNetworkAlert];
            [self.refreshControl endRefreshing];

        }
        else if (movies)
        {
            self.movies = movies;
            [self.tableView reloadData];
        }
        
        NSLog(@"end refreshing");
        [self.refreshControl endRefreshing];
    }];
}

- (void)noNetworkAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:@"Check your connection" preferredStyle:(UIAlertControllerStyleAlert)];
    /* // create a cancel action
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
     style:UIAlertActionStyleCancel
     handler:^(UIAlertAction * _Nonnull action) {
     // handle cancel response here. Doing nothing will dismiss the view.
     }];
     
     // add the cancel action to the alertController
     [alert addAction:cancelAction];
     */
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                         NSLog(@"handle ok");
                                                         [self.refreshControl endRefreshing];
                                                         NSLog(@"supposedly end refreshing");
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
        NSLog(@"end present view controller");

    }];
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"number of rows in section called");
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellforrowatindexpath called");
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    // NSLog(@"row: %d, section %d",
   //       indexPath.row, indexPath.section
    //      );
  //  cell.textLabel.text = [NSString stringWithFormat:@"row: %d, section %d",
   //                        indexPath.row, indexPath.section];
    
    cell.movie = self.movies[indexPath.row];

    

    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
       // [self.activityIndicator startAnimating];

        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Movie *movie = self.movies[indexPath.row];
        
        DetailCellViewController *detailCellViewController = [segue destinationViewController];
        detailCellViewController.movie = movie;
        NSLog(@"tapping on a movie!");
        //[NSThread sleepForTimeInterval:.15];
        //[self.activityIndicator stopAnimating];
    
    


}
@end
