//
//  MovieCell.m
//  Flix
//
//  Created by Jessica Shu on 6/28/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMovie:(Movie *)movie{
    _movie = movie;
    
    self.titleLabel.text = self.movie.title;
    self.synopsisLabel.text = self.movie.overview;
    NSString *posterURLString = self.movie.posterUrl;
    
    self.posterView.image = nil;
    if (posterURLString != nil)
    {
        NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        NSURL *posterURL  = [NSURL URLWithString:fullPosterURLString];
        [self.posterView setImageWithURL:posterURL];
        
    }
    
}


@end
