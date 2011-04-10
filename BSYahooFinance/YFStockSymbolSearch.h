//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <Foundation/Foundation.h>
@class ASIHTTPRequest;
@class YFStockSymbolSearch;

@protocol YFStockSymbolSearchDelegate <NSObject>
@optional
- (void)symbolSearchDidFinish:(YFStockSymbolSearch *)symbolFinder;
- (void)symbolSearchDidFail:(YFStockSymbolSearch *)symbolFinder;
@end

@interface YFStockSymbolSearch : NSObject {
    id<YFStockSymbolSearchDelegate> delegate;
    ASIHTTPRequest *symbolRequest;
    NSMutableArray *foundSymbols;
    NSError *internalError;
    BOOL synchronousSearch;
}
@property (nonatomic, assign) id<YFStockSymbolSearchDelegate> delegate;
@property (nonatomic, readonly) NSArray *symbols;
@property (nonatomic, readonly) NSError *error;
@property (nonatomic, assign) BOOL synchronousSearch;

+ (YFStockSymbolSearch *)symbolSearchWithDelegate:(id<YFStockSymbolSearchDelegate>)delegate;
- (id)initWithDelegate:(id<YFStockSymbolSearchDelegate>)delegate;
- (void)findSymbols:(NSString *)searchString;
- (void)cancel;

@end
