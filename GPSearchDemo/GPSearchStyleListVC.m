//
//  GPSearchVC.m
//  GPSearchDemo
//
//  Created by chen on 16/10/27.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//

#import "GPSearchStyleListVC.h"
#import "GPSearchVC.h"
#import "SearchResultVC.h"

@interface GPSearchStyleListVC () <GPSearchVCDelegate>

@end

@implementation GPSearchStyleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    // set title
    self.title = @"搜索样式";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 5 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
   
    if (indexPath.section == 0) { // 选择热门搜索风格
        cell.textLabel.text = @[@"GPHotSearchStyleDefault", @"GPHotSearchStyleColorfulTag", @"GPHotSearchStyleBorderTag", @"GPHotSearchStyleARCBorderTag", @"GPHotSearchStyleRankTag", @"GPHotSearchStyleRectangleTag"][indexPath.row];
    } else { // 选择搜索历史风格
        cell.textLabel.text = @[@"GPSearchHistoryStyleDefault", @"GPSearchHistoryStyleNormalTag", @"GPSearchHistoryStyleColorfulTag", @"GPSearchHistoryStyleBorderTag", @"GPSearchHistoryStyleARCBorderTag"][indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C#", @"C++", @"PHP", @"C", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    GPSearchVC *searchViewController = [GPSearchVC searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索商品" didSearchBlock:^(GPSearchVC *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        NSLog(@"-----------------------#4444444444---------------%@",searchText);

        [searchViewController.navigationController pushViewController:[SearchResultVC alloc] animated:YES];
    }];
    // 3. 设置风格
    if (indexPath.section == 0) { // 选择热门搜索
        searchViewController.hotSearchStyle = (NSInteger)indexPath.row; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = GPHotSearchStyleDefault; // 搜索历史风格为default
    } else { // 选择搜索历史
        searchViewController.hotSearchStyle = GPHotSearchStyleDefault; // 热门搜索风格为默认
        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row; // 搜索历史风格根据选择
    }
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器

    [self.navigationController pushViewController:searchViewController animated:YES];
    
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [self presentViewController:nav  animated:NO completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? @"选择搜索历史风格（热门搜索为默认风格）" : @"选择热门搜索风格（搜索历史为默认风格）";
}

#pragma mark -
#pragma mark - GPSearchViewControllerDelegate
//搜索建议
- (void)searchViewController:(GPSearchVC *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 5; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchAdvice = searchSuggestionsM;
        });
    }
}

//搜索历史
- (void)searchViewController:(GPSearchVC *)searchViewController
didSelectSearchHistoryAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText{
    
    NSLog(@"-----------------------111111111----------%ld-----%@",index,searchText);
    
    [searchViewController.navigationController pushViewController:[SearchResultVC alloc] animated:YES];
    
}
//热门搜索
- (void)searchViewController:(GPSearchVC *)searchViewController
   didSelectHotSearchAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText{
    NSLog(@"-----------------------2222222222----------%ld-----%@",index,searchText);
    
    [searchViewController.navigationController pushViewController:[SearchResultVC alloc] animated:YES];
    
}
//搜索框搜索
- (void)searchViewController:(GPSearchVC *)searchViewController
      didSearchWithSearchBar:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText{
    NSLog(@"-----------------------#3333333333---------------%@",searchText);
    
    [searchViewController.navigationController pushViewController:[SearchResultVC alloc] animated:YES];
    
}
@end
