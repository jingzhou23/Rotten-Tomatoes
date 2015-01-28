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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    
    
    self.titleLabel.text = self.movie[@"title"];
    
    self.synosisLabel.text = self.movie[@"synopsis"];
    
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    //self.scrollView.delegate = self;
    
    
    NSString *url = [self.movie valueForKeyPath:@"posters.thumbnail"];
    
    NSString *urlOri = [url stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
    
    NSLog(@"%@", urlOri);
    
    [self.posterView setImageWithURL:[NSURL URLWithString: urlOri]];
    
    
    [self.scrollView addSubview:self.self.posterView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.synosisLabel];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
