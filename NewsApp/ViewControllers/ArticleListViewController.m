//
//  ViewController.m
//  Some News App
//
//  Created by Adina Abilda on 22.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleListTableViewCell.h"
#import "ArticleDetailsViewController.h"
#import "Article.h"

@interface ArticleListViewController ()

@property (nonatomic, strong) NSArray *articles;

@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(fetchArticles) forControlEvents:UIControlEventValueChanged];

    [self fetchArticles];
}

- (void)fetchArticles {
    self.articles = [NSArray array];
    [Article fetchLatestWithBlock:^(NSArray *articles, NSError *error) {
        if (!error) {
            self.articles = articles;
            
            [self.tableView reloadData];
            
            if (self.refreshControl) {
                [self.refreshControl endRefreshing];
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ArticleListCell";
    Article *article = [self.articles objectAtIndex:indexPath.row];
    ArticleListTableViewCell *cell = (ArticleListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ArticleListCell" owner:self options:nil][0];
    }
    
    cell.title.text = article.title;
    cell.body.text = article.body;
    cell.publishedDate.text = article.formatPublishedAt;
    [cell.image setImageWithURL:article.imageUrl placeholderImage:[UIImage imageNamed:@"no-thumb.png"]];
    cell.image.layer.borderWidth = 0.5;
    cell.image.layer.borderColor = [UIColor blackColor].CGColor;
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 405, 1)];
    separatorLineView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    [cell.contentView addSubview:separatorLineView];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Article *article = [self.articles objectAtIndex:indexPath.row];
    ArticleDetailsViewController *detailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
    detailsViewController.article = article;
    
    [self presentViewController:detailsViewController animated:YES completion:nil];
}

@end
