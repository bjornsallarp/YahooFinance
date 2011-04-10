//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "YFStockDetailsLoader.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "YFStockDetails.h"

@interface YFStockDetailsLoader()
@property (nonatomic, retain) ASIHTTPRequest *internalStockRequest;
@property (nonatomic, retain) NSError *internalError;
@property (nonatomic, retain) YFStockDetails *internalStockDetails;
@property (nonatomic, retain) NSString *internalSymbolToLoad;
@end

@implementation YFStockDetailsLoader
@synthesize delegate;
@synthesize synchronousLoad;
@synthesize internalStockRequest;
@synthesize internalError;
@synthesize internalStockDetails;
@synthesize internalSymbolToLoad;
@dynamic error;
@dynamic stockDetails;

static NSString *yahooLoadStockDetailsURLString = @"http://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.quotes%%20where%%20symbol%%20%%3D%%20%%22%@%%22&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=cbfunc";


#pragma mark - Initializers

+ (YFStockDetailsLoader *)loaderWithDelegate:(id<YFStockDetailsLoaderDelegate>)delegate
{
    return [[[self alloc] initWithDelegate:delegate] autorelease];
}

- (id)initWithDelegate:(id<YFStockDetailsLoaderDelegate>)aDelegate
{
    if ((self = [super init])) {
        self.delegate = aDelegate;
    }
    
    return self;
}

#pragma mark - Implementation

- (void)loadDetails:(NSString *)stockSymbol
{
    [self cancel];
    self.internalSymbolToLoad = stockSymbol;
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:yahooLoadStockDetailsURLString, [stockSymbol stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    self.internalStockRequest = [ASIHTTPRequest requestWithURL:requestUrl];
    [self.internalStockRequest setCachePolicy:ASIDoNotReadFromCacheCachePolicy];
    self.internalStockRequest.delegate = self;
    [self.internalStockRequest setDidFinishSelector:@selector(requestDidFinish:)];
    [self.internalStockRequest setDidFailSelector:@selector(requestDidFail:)];
    
    if (self.synchronousLoad) {
        [self.internalStockRequest startSynchronous];        
    }
    else {
        [self.internalStockRequest startAsynchronous];
    }
}

- (void)cancel
{
    if (self.internalStockRequest) {
        [self.internalStockRequest clearDelegatesAndCancel];
        self.internalStockRequest = nil;
    }
    
    self.internalSymbolToLoad = nil;
    self.internalStockDetails = nil;
    self.internalError = nil;
}

#pragma mark - ASIHttpRequest delegate methods

- (void)requestDidFinish:(ASIHTTPRequest *)request
{
    // Remove the jsonp callback
    NSString *cleanJson = [[request responseString] substringFromIndex:7];
	cleanJson = [cleanJson substringToIndex:[cleanJson length]-2];
    
    SBJsonParser *parser = [SBJsonParser new];
	NSDictionary *parsedDictionary = [parser objectWithString:cleanJson];
	if (!parsedDictionary) {
        self.internalError = [NSError errorWithDomain:@"YFStockDetailsLoader" code:0 userInfo:
                              [NSDictionary dictionaryWithObject:parser.error forKey:NSLocalizedDescriptionKey]];
    }
	else {
        int resultCount = [[[parsedDictionary objectForKey:@"query"] objectForKey:@"count"] intValue];

        if (resultCount == 1) {
            NSDictionary *stockInfo = [[[parsedDictionary objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"quote"];
            if(stockInfo != nil) {
                self.internalStockDetails = [YFStockDetails stockDetailsWithDetails:stockInfo];
            }
        }

        if (self.internalStockDetails == nil) {
            self.internalError = [NSError errorWithDomain:@"YFStockDetailsLoader" code:0 userInfo:
                                  [NSDictionary dictionaryWithObject:@"Could not parse JSON result" forKey:NSLocalizedDescriptionKey]];
        }
    }
    
    [parser release];
    
    if (self.internalStockDetails != nil && self.internalError == nil) {
        [self.delegate stockDetailsDidLoad:self];
    }
    else {
        [self.delegate stockDetailsDidFail:self];
    }
}

- (void)requestDidFail:(ASIHTTPRequest *)request
{
    self.internalError = request.error;
    [self.delegate stockDetailsDidFail:self];
}

#pragma mark - Accessors

- (NSError *)error
{
    return self.internalError;
}

- (YFStockDetails *)stockDetails
{
    return self.internalStockDetails;
}

#pragma mark - Memory management
- (void)dealloc
{
    [self cancel];
    [super dealloc];
}

@end
