//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <SenTestingKit/SenTestingKit.h>
#import "BSYahooFinance.h"

@interface BSYahooFinanceSymbolSearchTests : SenTestCase <YFStockSymbolSearchDelegate> {
@private
    YFStockSymbolSearch *symbolSearch;
}

@property (nonatomic, retain) YFStockSymbolSearch *symbolSearch;
@end
