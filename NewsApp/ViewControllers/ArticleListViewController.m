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

    [self fetchArticles];
}

- (void)fetchArticles {
    [Article fetchLatestWithBlock:^(NSArray *articles, NSError *error) {
        if (!error) {
            self.articles = articles;
            
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ArticleListCell";
    ArticleListTableViewCell *cell = (ArticleListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ArticleListCell" owner:self options:nil][0];
    }
    
    cell.title.text = [[self.articles objectAtIndex:indexPath.row] title];
    cell.body.text = [[self.articles objectAtIndex:indexPath.row] body];
    cell.publishedDate.text = [[self.articles objectAtIndex:indexPath.row] formatPublishedAt];
    cell.image.image = [UIImage imageNamed:@"no-thumb.png"];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Article *article = [self.articles objectAtIndex:indexPath.row];
    ArticleDetailsViewController *detailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
    detailsViewController.article = article;
    
    [self presentViewController:detailsViewController animated:YES completion:nil];
}

@end
