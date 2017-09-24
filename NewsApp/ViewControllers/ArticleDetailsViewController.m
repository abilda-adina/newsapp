//
//  ArticleDetailsViewController.m
//  NewsApp
//
//  Created by Adina Abilda on 24.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import "ArticleDetailsViewController.h"
#import "Article.h"

@interface ArticleDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UIButton *linkToSource;

@end

@implementation ArticleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.article.title;
    self.body.text = self.article.body;
}

- (IBAction)goToArticleSource:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:self.article.url options:@{} completionHandler:nil];
}

@end
