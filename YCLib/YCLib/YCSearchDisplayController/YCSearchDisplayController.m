//
//  YCSearchDisplayController.m
//  testNavC
//
//  Created by li shiyong on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+YC.h"
#import "NSObject+YC.h"
#import "UISearchBar+YC.h"
#import "YCSearchDisplayController.h"

@interface YCSearchDisplayController ()

- (void)handleKeyboardDidShow:(NSNotification*)aNotification;
- (void)registerNotifications;
- (void)unRegisterNotifications;

@end

@implementation YCSearchDisplayController
@synthesize active = _active, delegate = _delegate, contentsController = _contentsController, searchBar = _searchBar;
@synthesize searchResultsTableView = _searchResultsTableView;

- (void)setSearchResultsDataSource:(id)searchResultsDataSource{
    _searchResultsTableView.dataSource = searchResultsDataSource;    
}

- (id)searchResultsDataSource{
    return _searchResultsTableView.dataSource;
}

- (void)setSearchResultsDelegate:(id)searchResultsDelegate{
    _searchResultsTableView.delegate = searchResultsDelegate;    
}

- (id)searchResultsDelegate{
    return _searchResultsTableView.delegate;
}

- (void)setActive:(BOOL)active animated:(BOOL)animated{
    if (_active == active) 
        return;
    _active = active;

    
    UINavigationController *navController = _contentsController.navigationController;
    UINavigationItem *navigationItem =  _contentsController.navigationItem;
    UINavigationBar *navBar = _contentsController.navigationController.navigationBar;
    BOOL searchBarInNavBar = (_searchBar == navigationItem.titleView);//searchBar是否在navBar中
    NSTimeInterval duration = animated ? 0.25 : 0.0;
        
    //cancel 按钮
    [_searchBar setShowsCancelButton:active animated:animated];
    
    //navBar
    if (!searchBarInNavBar) {
        [navController setNavigationBarHidden:active animated:animated];
    }else {
        if (active) {
            [_leftItemOfNavBar release];
            [_rightItemOfNavBar release];
            _leftItemOfNavBar = [navigationItem.leftBarButtonItem retain];
            _rightItemOfNavBar = [navigationItem.rightBarButtonItem retain];
            [navigationItem setLeftBarButtonItem:nil animated:animated];
            [navigationItem setRightBarButtonItem:nil animated:animated];
            
            
            //解决titleView在有rightBarButtonItem或leftBarButtonItem的时候不拉伸到尽头
            CGRect titleViewFrame = CGRectInset(navBar.bounds, 5, 0);
            [UIView transitionWithView:navBar duration:duration -0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                navigationItem.titleView.frame = titleViewFrame;
            } completion:NULL];
            
            
        }else {
            [navigationItem setLeftBarButtonItem:_leftItemOfNavBar animated:animated];
            [navigationItem setRightBarButtonItem:_rightItemOfNavBar animated:animated];
        }
        
    }

    
    //淡黑的视图、resultTabeleView
    [UIView transitionWithView:_contentsController.view duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        if (active) {
            //_dimmingView的Frame = _searchBar向下偏移
            CGRect searchBarFrame = [_contentsController.view convertRect:_searchBar.frame fromView:_searchBar.superview];
            CGRect dimmingViewFrame = CGRectOffset(_contentsController.view.bounds, 0.0, searchBarFrame.origin.y + searchBarFrame.size.height);
            _dimmingView.frame = dimmingViewFrame;
            
            [_contentsController.view addSubview:_dimmingView];
            
            //tableView
            if (_searchBar.text && [_searchBar.text stringByTrim].length > 0) {
                
                if ([_delegate respondsToSelector:@selector(searchDisplayController:shouldReloadTableForSearchString:)]) {
                    if ([_delegate searchDisplayController:self shouldReloadTableForSearchString:_searchBar.text]) {
                        [_searchResultsTableView reloadData];
                        if ([_searchResultsTableView numberOfRowsInSection:0] > 0) 
                            [_contentsController.view addSubview:_searchResultsTableView];
                    }
                }
                
            }
            
        }else {
            [_dimmingView removeFromSuperview];
            [_searchResultsTableView removeFromSuperview];
        } 
    } completion:NULL];
    
    
    //searchBar:键盘，等待指示，文本颜色
    if (active) {
        [_searchBar becomeFirstResponder];
        _searchBar.textField.textColor = [UIColor darkTextColor];
    }else {
        [_searchBar setShowsSearchingView:NO];
        [_searchBar resignFirstResponder];
        _searchBar.textField.textColor = [UIColor grayColor];
    }

    //调用 delegate ,结束状态
    if (!active) {
        if ([_delegate respondsToSelector:@selector(searchDisplayControllerDidEndSearch:)]) {
            [_delegate searchDisplayControllerDidEndSearch:self];
        }
    }
     
}

- (void)setActive:(BOOL)active{
    [self setActive:active animated:NO];
}

- (void)hidesSearchResultsTableViewWithAnimated:(BOOL)animated{
    NSTimeInterval duration = animated ? 0.25 : 0.0;
    [UIView transitionWithView:_contentsController.view duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [_searchResultsTableView removeFromSuperview];
    } completion:NULL];
}

- (id)initWithSearchBar:(UISearchBar *)searchBar contentsController:(UIViewController *)viewController{
    self = [super init];
    if (self) {        
        _searchBar = [searchBar retain];
        _contentsController = [viewController retain];
        _searchBar.textField.delegate = self;
        
        //
        CGRect dimmingViewFrame = _contentsController.view.bounds;
        _dimmingView = [[UIControl alloc] initWithFrame:dimmingViewFrame];
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0.03 alpha:0.85];
        [(UIControl*)_dimmingView addTarget:self action:@selector(dimmingViewTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        //
        CGRect tableViewFrame = _contentsController.view.bounds;
        tableViewFrame = CGRectOffset(tableViewFrame, 0.0, _searchBar.bounds.size.height);
        _searchResultsTableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
        
        //
        [self registerNotifications];
        
    }
    return self;
}

#pragma mark - 

- (void)dimmingViewTapped:(id)sender{
    [self setActive:NO animated:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self setActive:YES animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self setActive:NO animated:YES];
}

#pragma mark - Notification

- (void)handleTextFieldTextDidChange:(NSNotification*)aNotification{    
    if (aNotification.object != _searchBar.textField)
        return;
    
    NSString *string = [(UITextField*)aNotification.object text];

    //调用 delegate 
    if ([_delegate respondsToSelector:@selector(searchDisplayController:shouldReloadTableForSearchString:)]) {
        if ([_delegate searchDisplayController:self shouldReloadTableForSearchString:string]) {
            [_searchResultsTableView reloadData];
            
            [UIView transitionWithView:_contentsController.view duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                if ([_searchResultsTableView numberOfRowsInSection:0] > 0) {
                    [_contentsController.view addSubview:_searchResultsTableView];
                }else {
                    [_searchResultsTableView removeFromSuperview];
                }
            } completion:NULL];
        }
    }
    
}


- (void)handleKeyboardDidShow:(NSNotification*)aNotification{	
    NSDictionary* info = [aNotification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameForWindow = [aValue CGRectValue];//这个frame是Window的坐标系统的，下面要转换
    CGRect keyboardFrame = [_contentsController.view.window convertRect:keyboardFrameForWindow toView:_contentsController.view];
    
    //tableView的Frame = _searchBar向下偏移
    CGRect searchBarFrame = [_contentsController.view convertRect:_searchBar.frame fromView:_searchBar.superview];
    CGRect tableViewFrame = CGRectOffset(_contentsController.view.bounds, 0.0, searchBarFrame.origin.y + searchBarFrame.size.height);
    //tableView的高度 ＝ 键盘原点y 减去 tableView frame的原点y
    tableViewFrame.size.height = keyboardFrame.origin.y - tableViewFrame.origin.y;
    
    _searchResultsTableView.frame = tableViewFrame;
}

- (void)registerNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(handleKeyboardDidShow:)
                               name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(handleTextFieldTextDidChange:)
                               name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)unRegisterNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];    
	[notificationCenter removeObserver:self	name: UIKeyboardDidShowNotification object: nil];
    [notificationCenter removeObserver:self	name: UITextFieldTextDidChangeNotification object: nil];
}

- (void)dealloc{
    [self unRegisterNotifications];
    [_contentsController release];
    [_searchResultsTableView release];
    [_searchBar release];
    [_leftItemOfNavBar release];
    [_rightItemOfNavBar release];
    [super dealloc];
}

@end
