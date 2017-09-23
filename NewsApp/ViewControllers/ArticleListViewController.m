//
//  ViewController.m
//  Some News App
//
//  Created by Adina Abilda on 22.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleListTableViewCell.h"
#import "Article.h"

@interface ArticleListViewController ()

@property (nonatomic, strong) NSArray *articles;

@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.articles = [NSArray arrayWithObject:[[Article alloc] initWithAttributes:@{@"title":@"Test title", @"author":@"Sultan Abilda", @"description":@"Test body", @"url": @"", @"urlToImage":@"", @"publishedAt":@"2017-09-23T17:41:16Z"}]];

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
    cell.publishedDate.text = [[self.articles objectAtIndex:indexPath.row] publishedAt];
    cell.image.image = [UIImage imageNamed:@"no-thumb.png"];
    
    return cell;
}

@end
