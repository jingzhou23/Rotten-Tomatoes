//
//  MovieCell.h
//  Rotten Tomatoes
//
//  Created by Jing Zhou on 1/23/15.
//  Copyright (c) 2015 Jingzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagePoster;

@end
