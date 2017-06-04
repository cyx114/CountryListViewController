//
//  CountryListViewController.m
//  SearchBar
//
//  Created by xiacheng on 2017/6/4.
//  Copyright © 2017年 xiacheng. All rights reserved.
//

#import "CountryListViewController.h"
#import "EJMacroDefinition.h"


@interface CountryListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UIView *naviBarView;

@property (nonatomic, strong) UISearchBar *countrySearchBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *countryArr;

@property (nonatomic, strong) NSMutableArray *searchResultArr;

@property (nonatomic, strong) NSMutableArray *currentDataArr;

@property (nonatomic, strong) UIView *coverView;  //搜索之前的coverView

@property (nonatomic, strong) UILabel *noDataLabel; //没有结果时的提醒语

@end

static NSString *CountryCellId = @"CountryCellId";

@implementation CountryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self p_config];
    [self p_initSubViews];
}
- (void)p_config
{
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"AAA",@"BBB",@"CCC",@"DDD",@"EEE"];
    _countryArr = [NSMutableArray new];
    for (int i=0; i<5; i++) {
        for (NSString *country in arr) {
            [_countryArr addObject:country];
        }
    }
}

- (void)p_initSubViews
{
    _searchResultArr = [NSMutableArray new];
    
    //上面的导航栏
    _naviBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _naviBarView.backgroundColor = kBlueColor;
    [self.view addSubview:_naviBarView];
    
    //searchBar
    _countrySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 20, kScreenWidth - 120.0f, 44)];
    _countrySearchBar.searchBarStyle = UISearchBarStyleDefault;
    _countrySearchBar.tintColor = kBlueColor;
    _countrySearchBar.barTintColor = [UIColor blackColor];
    _countrySearchBar.delegate = self;
//    _countrySearchBar.showsCancelButton = YES;
    _countrySearchBar.placeholder = @"选择地区";
    [_countrySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_countrySearchBar setBackgroundImage:[UIImage new]];
    UITextField*searchField = [_countrySearchBar valueForKey:@"_searchField"];
    //更改searchBar 中PlaceHolder 字体颜色
    [searchField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchField.textColor= [UIColor blackColor];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    searchField.layer.cornerRadius = 14.0f;
//    searchField.layer.borderColor = [UIColor clearColor].CGColor;
//    searchField.layer.borderWidth = 1;
    searchField.layer.masksToBounds = YES;
    
    
    [_naviBarView addSubview:_countrySearchBar];
    
    
    //tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _currentDataArr = _countryArr;
    
    [self.view addSubview:_tableView];
    
}



#pragma mark - UITableViewDataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentDataArr.count < 1) {
        self.noDataLabel.hidden = NO;
    }else{
        self.noDataLabel.hidden = YES;
    }
    return self.currentDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CountryCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CountryCellId];
    }
    cell.textLabel.text = self.currentDataArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select: %@",self.currentDataArr[indexPath.row]);
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (!searchText || searchText.length < 1) {
        _currentDataArr = _countryArr;
        [self.tableView reloadData];
        [self.view addSubview:self.coverView];
        return;
    }else{
        [self.coverView removeFromSuperview];   
    }
    [_searchResultArr removeAllObjects];
    for (NSString *country in _countryArr) {
        if ([country rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [_searchResultArr addObject:country];
        }
    }
    _currentDataArr = _searchResultArr;
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _currentDataArr = _countryArr;
    [self.tableView reloadData];
    searchBar.text = nil;
    [searchBar endEditing:YES];
    [_searchResultArr removeAllObjects];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (searchBar.text.length < 1) {
        _currentDataArr = _countryArr;
        [self.tableView reloadData];
        searchBar.text = nil;
        [searchBar endEditing:YES];
        [_searchResultArr removeAllObjects];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    _currentDataArr = _searchResultArr;
//    [self.tableView reloadData];
    [self.view addSubview:self.coverView];
    return YES;
}

#pragma mark - Getters and Setters 

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_coverView addGestureRecognizer:ges];
    }
    return _coverView;
}

- (UILabel *)noDataLabel
{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _noDataLabel.center = self.view.center;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.text = @"NO Result";
        [self.view addSubview:_noDataLabel];
        [self.view bringSubviewToFront:self.noDataLabel];
    }
    return _noDataLabel;
}

#pragma mark - Event Actions

- (void)tapAction
{
    _currentDataArr = _countryArr;
    [self.tableView reloadData];
    [self.coverView removeFromSuperview
     ];
    self.countrySearchBar.text = nil;
    [self.countrySearchBar endEditing:YES];
}


@end
