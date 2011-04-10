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

@interface DetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, YFStockDetailsLoaderDelegate> {
    UITableView *stockDetails;
    YFStockSymbol *symbol;
    YFStockDetailsLoader *detailsLoader;
    NSArray *detailKeys;
}

@property (nonatomic, retain) IBOutlet UITableView *stockDetails;
@property (nonatomic, retain) YFStockSymbol *stockSymbol;

@end
