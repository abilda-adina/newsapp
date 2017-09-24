//
//  NewsListTableViewCell.h
//  Some News App
//
//  Created by Adina Abilda on 22.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ArticleListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *publishedDate;

@end
