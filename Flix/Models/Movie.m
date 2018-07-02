//
//  Movie.m
//  Flix
//
//  Created by Jessica Shu on 7/2/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    self.title = dictionary[@"title"];
    self.overview = dictionary[@"overview"];
    self.posterUrl = dictionary[@"poster_path"];
    self.backdropPath = dictionary[@"backdrop_path"];
    self.releaseDate = dictionary[@"release_date"];
    return self;
}

+(NSArray *)moviesWithDictionaries:(NSArray *)dictionaries{
    NSMutableArray* movies = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries){
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
        // NSLog(@"%@", movie.title);
    }
    return movies;
}

@end
