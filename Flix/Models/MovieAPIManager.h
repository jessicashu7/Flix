//
//  MovieAPIManager.h
//  Flix
//
//  Created by Jessica Shu on 7/2/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieAPIManager : NSObject
@property (nonatomic, strong) NSURLSession *session;

-(id) init;

-(void) fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;

@end
