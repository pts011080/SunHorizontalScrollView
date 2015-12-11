//
//  TestTableViewController.m
//  SunHorizontalScrollView
//
//  Created by Midland on 10/12/15.
//  Copyright © 2015 孙博弘. All rights reserved.
//

#import "TestTableViewController.h"
#import "SunHorizontalScrollView.h"

@interface TestTableViewController ()<SunHorizontalScrollViewDelegate>

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row % 2 ? tableView.frame.size.width : tableView.frame.size.width/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SunHorizontalScrollView *scrollView;
    
    static NSString * const cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
        //create and set delegate of the SunHorizontalScrollView
        scrollView = [SunHorizontalScrollView new];
        scrollView.delegate = self;
        scrollView.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        scrollView.flowLayout.minimumLineSpacing = 20;
        scrollView.tag = 10;    //set tag for cell to retrive from subviews array
        [cell addSubview:scrollView];
        
        scrollView.collectionView.pagingEnabled = YES;
        
        scrollView = nil;
    }
    
    scrollView = (SunHorizontalScrollView *) [cell viewWithTag:10]; //* retrive from cell subview
    scrollView.atRowIndex = indexPath.row; //here to set the atRowIndex to SunHorizontalScrollView
    
    //for dynamic cell height change, here to set the scroview height and item size
    scrollView.frame = CGRectMake(0, 0, tableView.frame.size.width, indexPath.row % 2 ? tableView.frame.size.width : tableView.frame.size.width/2);    //set the SunHorizontalScrollView frame size
    scrollView.flowLayout.itemSize     = CGSizeMake((indexPath.row % 2 ? tableView.frame.size.width : tableView.frame.size.width/2 ) - 20, (indexPath.row % 2 ? tableView.frame.size.width : tableView.frame.size.width/2) - 20 ); //set the SunHorizontalScrollView ithe frame size
    
    [scrollView setData:@[
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     [SunHorizontalScrollMedia mediaWithType:SunHorizontalScrollMediaTypeImageURL
                                                      object:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/05/28/05/03/portrait-787522_640.jpg"]],
                     ]
     ];
    
    [cell setBackgroundColor:[UIColor blueColor]];
    // Configure the cell...
    
    return cell;
}

#pragma mark - SUNImageScrollViewDelegate
- (void)collectionView:(SunHorizontalScrollView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"[TableView] row:%d, media selected:%d", (int)collectionView.atRowIndex, (int)indexPath.row);
    
    NSLog(@"current page: %d and total pages: %d",(int)collectionView.currentPage,(int)collectionView.totalPages);
}

@end
