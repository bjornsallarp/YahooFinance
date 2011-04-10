//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSYahooFinanceLoadDetailsTest.h"

@implementation BSYahooFinanceLoadDetailsTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Tests

- (void)testLoadDetailsAsynchronous
{
    didFailCalled = NO;
    didFinishCalled = NO;
    
    YFStockDetailsLoader *loader = [YFStockDetailsLoader loaderWithDelegate:self];
    [loader loadDetails:@"YHOO"];
    
    while (didFailCalled == NO && didFinishCalled == NO) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
    
    STAssertNil(loader.error, @"Stock details failed to load with error: %@", [loader.error localizedDescription]);

    if (![loader.stockDetails.name isEqualToString:@"Yahoo! Inc."]) {
        STFail(@"Stock details name expexted to be Yahoo! Inc., but was %@", loader.stockDetails.name);
    }
}

- (void)testLoadDetailsSynchronous
{
    YFStockDetailsLoader *loader = [YFStockDetailsLoader loaderWithDelegate:self];
    loader.synchronousLoad = YES;
    [loader loadDetails:@"YHOO"];
    
    STAssertNil(loader.error, @"Stock details failed to load with error: %@", [loader.error localizedDescription]);
    
    if (![loader.stockDetails.name isEqualToString:@"Yahoo! Inc."]) {
        STFail(@"Stock details name expexted to be Yahoo! Inc., but was %@", loader.stockDetails.name);
    }
}

- (void)stockDetailsDidFail:(YFStockDetailsLoader *)detailsLoader
{
    didFailCalled = YES;
}

- (void)stockDetailsDidLoad:(YFStockDetailsLoader *)detailsLoader
{
    didFinishCalled = YES;
}

@end
