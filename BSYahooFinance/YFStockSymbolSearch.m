//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "YFStockSymbolSearch.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "YFStockSymbol.h"

@interface YFStockSymbolSearch()
@property (nonatomic, retain) ASIHTTPRequest *symbolRequest;
@property (nonatomic, retain) NSMutableArray *foundSymbols;
@property (nonatomic, retain) NSError *internalError;
@end

@implementation YFStockSymbolSearch
@synthesize delegate;
@synthesize symbolRequest;
@synthesize internalError;
@synthesize foundSymbols;
@synthesize synchronousSearch;
@dynamic error;
@dynamic symbols;

static NSString *yahooSymbolSearchURLString = @"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&callback=YAHOO.Finance.SymbolSuggest.ssCallback";

#pragma mark - Initializers

+ (YFStockSymbolSearch *)symbolSearchWithDelegate:(id<YFStockSymbolSearchDelegate>)delegate
{
    return [[[self alloc] initWithDelegate:delegate] autorelease];
}

- (id)initWithDelegate:(id<YFStockSymbolSearchDelegate>)aDelegate
{
    if((self = [super init])) {
        self.delegate = aDelegate;
    }
    
    return self;
}

#pragma mark - Implementation

- (void)findSymbols:(NSString *)searchString
{
    // Cancel any running request
    [self cancel];
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:yahooSymbolSearchURLString, [searchString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    self.symbolRequest = [ASIHTTPRequest requestWithURL:requestUrl];
    self.symbolRequest.delegate = self;
    [self.symbolRequest setDidFinishSelector:@selector(requestDidFinish:)];
    [self.symbolRequest setDidFailSelector:@selector(requestDidFail:)];

    if (self.synchronousSearch) {
        [self.symbolRequest startSynchronous];        
    }
    else {
        [self.symbolRequest startAsynchronous];
    }
}

- (void)cancel
{
    if (self.symbolRequest) {
        [self.symbolRequest clearDelegatesAndCancel];
        self.symbolRequest = nil;
    }
    
    self.foundSymbols = nil;
    self.internalError = nil;
}

#pragma mark - ASIHttpRequest delegate methods

- (void)requestDidFinish:(ASIHTTPRequest *)request
{
    // Remove the jsonp callback
    NSString *cleanJson = [[request responseString] substringFromIndex:39];
	cleanJson = [cleanJson substringToIndex:[cleanJson length]-1];
    
    SBJsonParser *parser = [SBJsonParser new];
	NSDictionary *parsedDictionary = [parser objectWithString:cleanJson];
	if (!parsedDictionary) {
        self.internalError = [NSError errorWithDomain:@"YFStockSymbolSearch" code:0 userInfo:
                              [NSDictionary dictionaryWithObject:parser.error forKey:NSLocalizedDescriptionKey]];
    }
	else {
        NSDictionary *stockCurrency = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StockExchangeCurrency" ofType:@"plist"]];
        
        NSArray *symbols = [[parsedDictionary objectForKey:@"ResultSet"] objectForKey:@"Result"];
		int len = [symbols count];
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:len];
    
		for (int i = 0; i < len; i++) {
			YFStockSymbol *symbol = [[YFStockSymbol alloc] init];
            symbol.symbol = [[symbols objectAtIndex:i] objectForKey:@"symbol"];
            symbol.name = [[symbols objectAtIndex:i] objectForKey:@"name"];
            symbol.currency = @"USD";
            
            // Try to look up the currency using the prefix of the stock symbol at Yahoo
            for (NSString *key in stockCurrency) {
                if ([symbol.symbol hasSuffix:key]) {
                    symbol.currency = [stockCurrency valueForKey:key];
                    break;
                }
            }
        
			[result addObject:symbol];
            [symbol release];
		}
        
        self.foundSymbols = result;
    }
    
    [parser release];
    
    if (self.foundSymbols != nil && self.internalError == nil) {
        [self.delegate symbolSearchDidFinish:self];
    }
    else {
        [self.delegate symbolSearchDidFail:self];
    }
}

- (void)requestDidFail:(ASIHTTPRequest *)request
{
    self.internalError = request.error;
    [self.delegate symbolSearchDidFail:self];
}

#pragma mark - Accessors

- (NSArray *)symbols
{
    if (self.foundSymbols == nil) {
        return nil;
    }
    
    return [NSArray arrayWithArray:self.foundSymbols];
}

- (NSError *)error
{
    return self.internalError;
}

#pragma mark - Memory management
- (void)dealloc
{
    [self cancel];
    [super dealloc];
}
@end
