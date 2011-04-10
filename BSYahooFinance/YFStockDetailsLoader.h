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
@class YFStockDetailsLoader;
@class YFStockDetails;

@protocol YFStockDetailsLoaderDelegate <NSObject>
@optional
- (void)stockDetailsDidLoad:(YFStockDetailsLoader *)detailsLoader;
- (void)stockDetailsDidFail:(YFStockDetailsLoader *)detailsLoader;
@end

@interface YFStockDetailsLoader : NSObject {
    id<YFStockDetailsLoaderDelegate> delegate;
    ASIHTTPRequest *internalStockRequest;
    NSError *internalError;
    YFStockDetails *internalStockDetails;
    NSString *internalSymbolToLoad;
    BOOL synchronousLoad;
}

@property (nonatomic, assign) id<YFStockDetailsLoaderDelegate> delegate;
@property (nonatomic, readonly) NSError *error;
@property (nonatomic, readonly) YFStockDetails *stockDetails;
@property (nonatomic, assign) BOOL synchronousLoad;

+ (YFStockDetailsLoader *)loaderWithDelegate:(id<YFStockDetailsLoaderDelegate>)delegate;
- (id)initWithDelegate:(id<YFStockDetailsLoaderDelegate>)delegate;
- (void)loadDetails:(NSString *)stockSymbol;
- (void)cancel;

@end
