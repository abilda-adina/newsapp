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

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UIButton *linkToSource;

@end

@implementation ArticleDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.article.title;
    self.body.text = self.article.body;
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToArticleSource:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:self.article.url options:@{} completionHandler:nil];
}

@end
