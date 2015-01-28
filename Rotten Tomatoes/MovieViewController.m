//
//  MovieViewController.m
//  Rotten Tomatoes
//
//  Created by Jing Zhou on 1/20/15.
//  Copyright (c) 2015 Jingzh. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "MBProgressHUD.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIRefreshControl *refreshControl;

@end

@implementation MovieViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=4pq68yhq4dxszaw2hsdx53t5"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil){
            
            self.title=@"Movies";
            
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies = responseDictionary[@"movies"];
            
            [self.tableView reloadData];
            
            NSLog(@"response: %@", responseDictionary);
        }
        else {
            NSLog(@"reload failed");
            self.movies = nil;
            self.title=@"network error";
            
        }
        
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = 106;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadApi) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void)reloadApi{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=4pq68yhq4dxszaw2hsdx53t5"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil){
            
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies = responseDictionary[@"movies"];
            
            [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
            
            
            NSLog(@"reloaded");
        }
        else {
            NSLog(@"reload failed");
            self.movies = nil;
            
        }
        
        
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self.refreshControl endRefreshing];
    
    [self.tableView reloadData];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.movies == nil) return 0;
    else return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movies = self.movies[indexPath.row];
    
    
    if (self.movies == nil) {
        self.title=@"network error";
        
    }
    
    else {
        self.title=@"Movies";
        
        cell.titleLabel.text = movies[@"title"];
        cell.synopsisLabel.text = movies[@"synopsis"];
        [cell.imagePoster setImageWithURL:[NSURL URLWithString:[movies valueForKeyPath:@"posters.thumbnail"]]];
        
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailViewController *vc = [[MovieDetailViewController alloc] init];
    
    vc.movie = self.movies[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
