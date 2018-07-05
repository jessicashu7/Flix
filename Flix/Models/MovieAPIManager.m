//
//  MovieAPIManager.m
//  Flix
//
//  Created by Jessica Shu on 7/2/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "MovieAPIManager.h"
#import "Movie.h"

@implementation MovieAPIManager

- (id)init {
    self = [super init];
    self.session =[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    return self;
}

-(void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            
            completion(nil, error);
            NSLog(@"error");
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dataDictionary);
            
            NSArray *dictionaries = dataDictionary[@"results"];
            NSArray *movies = [Movie moviesWithDictionaries:dictionaries];
            
            
            //self.movies = dataDictionary[@"results"];
            //for (NSDictionary *movie in self.movies){
            //    NSLog(@"%@", movie[@"title"]);
            //}
            completion(movies, nil);
        }
    }];
    [task resume];
}
@end



