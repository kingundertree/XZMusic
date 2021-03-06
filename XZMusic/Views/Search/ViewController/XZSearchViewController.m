//
//  XZSearchViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-31.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSearchViewController.h"
#import "XZMusicDataCenter.h"
#import "XZMusicSingerModel.h"
#import "XZTableForSingerList.h"
#import "XZSingerInfoCell.h"
#import "XZSingerSongListViewController.h"


@interface XZSearchViewController () <XZBaseTableEventDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *singerListArr;
@property(nonatomic, strong) XZTableForSingerList *tableView;
@property(nonatomic, strong) UISearchBar *searchBar;
@end

@implementation XZSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 44)];
        _searchBar.delegate        = self;
        _searchBar.placeholder     = @"搜索";
        _searchBar.tintColor       = [UIColor XZBlackColor];
        _searchBar.keyboardType    = UIKeyboardTypeDefault;
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.backgroundImage = [UIImage createImageWithColor:[UIColor XZBgPageColor]];
        [_searchBar setImage:[UIImage imageNamed:@"music_seach_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }
    return _searchBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    [self initData];
    [self initUI];
    [self addNotifycation];

    [self showLoading];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        [self getSingerData];
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [XZAppDelegate sharedAppDelegate].menuMainVC.isOnFirstView = YES;
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)initData{
    self.singerListArr = [NSMutableArray array];
}

- (void)initUI{
    self.navigationItem.titleView = self.searchBar;
    [self addRightButton:@"取消"];
    
    self.tableView = [[XZTableForSingerList alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.eventDelegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark --XZBaseTableEventDelegate
- (void)tableStatus:(enum XZBaseTableStatus)status{

}

#pragma mark
#pragma leftButtonAction
- (void)doBack:(id)sender{
    [[XZAppDelegate sharedAppDelegate].menuMainVC mainVCLeftMenuAction];
}

-(void)getSingerData{
    if (self.singerListArr.count > 0) {
        return;
    }
    
    self.singerListArr = [[XZMusicDataCenter shareInstance] searchMusicWithKeyword:@"周杰伦"];

    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新界面
        self.tableView.tableData = self.singerListArr;
        [self.tableView reloadData];
        
        [self hideLoading];
        DLog(@"歌手列表--->>%lu/%@",(unsigned long)self.singerListArr.count,self.singerListArr)
    });
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.singerListArr = [[XZMusicDataCenter shareInstance] topMusic100];
    }else{
        self.singerListArr = [[XZMusicDataCenter shareInstance] searchMusicWithKeyword:searchText];
    }
    self.tableView.tableData = self.singerListArr;
    [self.tableView reloadData];
    
    if (!self.singerListArr || self.singerListArr.count == 0) {
        [self showTips:@"换个词继续搜索看看~"];
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UITableViewEventDelegate
- (void)didSelect:(id)data indexPath:(NSIndexPath *)indexPath{
    if (self.navigationController.view.frame.origin.x != 0) {
        return;
    }

    [XZAppDelegate sharedAppDelegate].menuMainVC.isOnFirstView = NO;

    XZMusicSingerModel *singerInfoMode = (XZMusicSingerModel *)[self.singerListArr objectAtIndex:indexPath.row];
    XZSingerSongListViewController *singerSongListVC = [[XZSingerSongListViewController alloc] init];
    singerSongListVC.singerInfoModel = singerInfoMode;
    [self.navigationController pushViewController:singerSongListVC animated:YES];
}

#pragma mark --method
- (void)rightButtonAction:(id)sender{
    [self.searchBar resignFirstResponder];
}
- (void)addNotifycation
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboardNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - Keyboard notifications

- (void)handleWillShowKeyboardNotification:(NSNotification *)notification{
    [self resetTableViewFrame:notification];
}

- (void)handleWillHideKeyboardNotification:(NSNotification *)notification{
    [self resetTableViewFrame:notification];
}

- (void)resetTableViewFrame:(NSNotification *)notification{
    CGRect keyboardRect = [(notification.userInfo)[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = ScreenHeight - 64 - keyboardY;
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
