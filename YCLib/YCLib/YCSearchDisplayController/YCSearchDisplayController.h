//
//  YCSearchDisplayController.h
//  testNavC
//
//  Created by li shiyong on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCSearchDisplayDelegate;

@interface YCSearchDisplayController : NSObject<UITextFieldDelegate>{
    BOOL                        _active;
    UIViewController           *_contentsController;
    UITableView                *_searchResultsTableView;
    UISearchBar                *_searchBar;
    id<YCSearchDisplayDelegate> _delegate;
    //id<UITableViewDataSource>   _searchResultsDataSource;
    //id<UITableViewDelegate>     _searchResultsDelegate;
    
    UIView                     *_dimmingView;
    
    UIBarButtonItem *_leftItemOfNavBar;
    UIBarButtonItem *_rightItemOfNavBar;
}

- (id)initWithSearchBar:(UISearchBar *)searchBar contentsController:(UIViewController *)viewController;

@property(nonatomic,assign)                           id<YCSearchDisplayDelegate> delegate;

@property(nonatomic,getter=isActive)  BOOL            active;  
- (void)setActive:(BOOL)active animated:(BOOL)animated;       

@property(nonatomic,readonly)  UISearchBar                *searchBar;
@property(nonatomic,readonly)  UIViewController           *contentsController; 
@property(nonatomic,readonly)  UITableView                *searchResultsTableView;   
@property(nonatomic,assign)    id<UITableViewDataSource>   searchResultsDataSource;  
@property(nonatomic,assign)    id<UITableViewDelegate>     searchResultsDelegate; 

- (void)hidesSearchResultsTableViewWithAnimated:(BOOL)animated;

@end


@protocol YCSearchDisplayDelegate <NSObject>

@optional

- (void)searchDisplayControllerDidEndSearch:(YCSearchDisplayController *)controller;

- (BOOL)searchDisplayController:(YCSearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;

/*
// when we start/end showing the search UI
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller;
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller;
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller;
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller;

// called when the table is created destroyed, shown or hidden. configure as necessary.
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView;
- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView;

// called when table is shown/hidden
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView;
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView;
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView;
- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView;

// return YES to reload table. called when search string/option changes. convenience methods on top UISearchBar delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption;
*/
 
@end