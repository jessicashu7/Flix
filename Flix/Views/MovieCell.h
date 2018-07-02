//
//  MovieCell.h
//  Flix
//
//  Created by Jessica Shu on 6/28/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (nonatomic, strong) Movie *movie;


@end
