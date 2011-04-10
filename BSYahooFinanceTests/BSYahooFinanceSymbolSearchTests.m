//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSYahooFinanceSymbolSearchTests.h"

@implementation BSYahooFinanceSymbolSearchTests
@synthesize symbolSearch;

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    self.symbolSearch = nil;
    [super tearDown];
}

#pragma mark - Tests

- (void)testSearch
{
    self.symbolSearch = [YFStockSymbolSearch symbolSearchWithDelegate:self];
    self.symbolSearch.synchronousSearch = YES;
    [self.symbolSearch findSymbols:@"Google"];

    if (self.symbolSearch.error != nil) {
        STFail(@"Search failed due to: %@", [self.symbolSearch.error localizedDescription]);
    }
    else if ([self.symbolSearch.symbols count] < 1) {
        STFail(@"Search returned 0 symbols, expected at least 1");
    }
}

- (void)testCancelSearch
{
    self.symbolSearch = [YFStockSymbolSearch symbolSearchWithDelegate:self];
    [self.symbolSearch findSymbols:@"Goo"];
    [self.symbolSearch cancel];
    
    STAssertNil(self.symbolSearch.error, @"Expected error to be nil after cancelled search");
    STAssertNil(self.symbolSearch.symbols, @"Expected symbols to be 0 after a cancelled search");
}


- (void)testQuickSearch
{
    self.symbolSearch = [YFStockSymbolSearch symbolSearchWithDelegate:self];
    [self.symbolSearch findSymbols:@"Goo"];
    [self.symbolSearch findSymbols:@"Yahoo"];
    
    while (self.symbolSearch.error == nil && self.symbolSearch.symbols == nil) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
    }

    STAssertNil(self.symbolSearch.error, @"Search failed due to: %@", [self.symbolSearch.error localizedDescription]);
    
    if ([self.symbolSearch.symbols count] < 1) {
         STFail(@"Search returned 0 symbols, expected at least 1");
    }
    else {
        NSArray *result = self.symbolSearch.symbols;
        BOOL foundYahoo = NO;
        for (YFStockSymbol *symbol in result) {
            if ([symbol.name hasPrefix:@"Yahoo!"]) {
                foundYahoo = YES;
                break;
            }
        }
    
        STAssertTrue(foundYahoo, @"Searched for Yahoo but didn't find it!");
    }
}

- (void)symbolSearchDidFail:(YFStockSymbolSearch *)symbolFinder
{
    NSLog(@"Request did fail!");
}

- (void)symbolSearchDidFinish:(YFStockSymbolSearch *)symbolFinder
{
    NSLog(@"Request did finish");
}

@end
