//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//
#import <UIKit/UIKit.h>
#import "BSYahooFinance.h"


@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, YFStockSymbolSearchDelegate> {
    UITableView *symbolsSearchView;
    UISearchBar *searchBar;
    YFStockSymbolSearch *symbolSearch;
    NSArray *stockSymbols;
}

@property (nonatomic, retain) IBOutlet UITableView *symbolsSearchView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@end
