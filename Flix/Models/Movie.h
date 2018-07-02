//
//  Movie.h
//  Flix
//
//  Created by Jessica Shu on 7/2/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *posterUrl;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSString *backdropPath;
@property (nonatomic, strong) NSString *releaseDate;

- (id)initWithDictionary:(NSDictionary*)dictionary;

+(NSArray*)moviesWithDictionaries:(NSArray *)dictionaries;

@end
