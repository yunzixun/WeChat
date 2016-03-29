//
//  AddressbookViewController.m
//  WeChat
//
//  Created by Siegrain on 16/3/28.
//  Copyright © 2016年 siegrain. weChat. All rights reserved.
//

#import "ContactsViewController.h"
#import "UIImage+RandomImage.h"
#import "YSMChineseSort/Pod/Classes/NSArray+SortContact.h"

@interface
ContactsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, copy) NSArray* firstSectionData;

@property (nonatomic, copy) NSArray* contacts;
@property (nonatomic, copy) NSArray* headers;
@end
@implementation ContactsViewController
- (void)viewDidLoad
{
  [self initializeData];
  [self buildTableView];
}

- (void)initializeData
{
  self.firstSectionData = @[
    @[ @"plugins_FriendNotify", @"新的朋友" ],
    @[ @"add_friend_icon_addgroup", @"群聊" ],
    @[ @"Contact_icon_ContactTag", @"标签" ],
    @[ @"add_friend_icon_offical", @"公众号" ]
  ];

  self.contacts = @[
    @"吴正祥",
    @"陈维",
    @"赖杰",
    @"范熙丹",
    @"丁亮",
    @"赵雨彤",
    @"落落",
    @"Leo琦仔",
    @"廖宇超",
    @"Darui Li",
    @"刘洋"
  ];

  [self.contacts sortContactTOTitleAndSectionRow_A_EC:^(
                   BOOL isSuccess, NSArray* titleArray, NSArray* rowArray) {
    if (!isSuccess)
      return;

    self.contacts = rowArray;
    self.headers = titleArray;
  }];
}
- (void)buildTableView
{
  _tableView = ({
    UITableView* tableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                               self.view.frame.size.height - 44)
              style:UITableViewStylePlain];

    tableView.delegate = self;
    tableView.dataSource = self;

    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.rowHeight = 50;

    tableView;
  });

  [self.view addSubview:_tableView];
}
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{

  return self.headers.count + 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
  if (section == 0)
    return self.firstSectionData.count;

  return [self.contacts[section - 1] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  static NSString* identifier = @"contactsCellIdentifier";
  UITableViewCell* cell =
    [tableView dequeueReusableCellWithIdentifier:identifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }

  return cell;
}

- (void)tableView:(UITableView*)tableView
  willDisplayCell:(UITableViewCell*)cell
forRowAtIndexPath:(NSIndexPath*)indexPath
{
  if (indexPath.section == 0) {
    cell.imageView.image =
      [UIImage imageNamed:self.firstSectionData[indexPath.row][0]];
    cell.textLabel.text = self.firstSectionData[indexPath.row][1];
  } else {
    cell.imageView.image = [UIImage randromImageInPath:@"Images/cell_icons"];
    cell.textLabel.text = self.contacts[indexPath.section - 1][indexPath.row];
  }
}

- (UIView*)tableView:(UITableView*)tableView
  viewForHeaderInSection:(NSInteger)section
{
  if (section == 0)
    return nil;

  UIView* headerView = [[UIView alloc]
    initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
  headerView.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];

  UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  headerLabel.textColor = [UIColor lightGrayColor];
  headerLabel.font = [UIFont boldSystemFontOfSize:14];
  headerLabel.text = self.headers[section - 1];
  headerLabel.frame = CGRectMake(10, 0, headerView.bounds.size.width,
                                 headerView.bounds.size.height);

  [headerView addSubview:headerLabel];
  return headerView;
}
- (CGFloat)tableView:(UITableView*)tableView
  heightForHeaderInSection:(NSInteger)section
{
  return section == 0 ? 0 : 20;
}
@end
