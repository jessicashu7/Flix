//
//  MoviesGridViewController.m
//  Flix
//
//  Created by Jessica Shu on 6/29/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieCollectionViewCell.h"

@interface MoviesGridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchMovies];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:@"Check your connection" preferredStyle:(UIAlertControllerStyleAlert)];
 
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault              handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dataDictionary);
            
            self.movies = dataDictionary[@"results"];
            [self.collectionView reloadData];
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
    }];
    [task resume];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];

    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL  = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}


@end
