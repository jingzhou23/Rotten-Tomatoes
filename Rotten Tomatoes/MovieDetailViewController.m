//
//  MovieDetailViewController.m
//  Rotten Tomatoes
//
//  Created by Jing Zhou on 1/23/15.
//  Copyright (c) 2015 Jingzh. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *synosisLabel;

@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    
    self.titleLabel.text = self.movie[@"title"];
    
    self.synosisLabel.text = self.movie[@"synopsis"];

    NSString *url = [self.movie valueForKeyPath:@"posters.thumbnail"];
    
    NSString *urlOri = [url stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];

    NSLog(@"%@", urlOri);
    
    [self.posterView setImageWithURL:[NSURL URLWithString: urlOri]];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
