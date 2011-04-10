//
//  Created by Björn Sållarp on 2011-04-09.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//
#import "YFCurrencyConversion.h"
#import "YFTwoValueObject.h"

@interface YFCurrencyConverter()
@property (nonatomic, retain) NSMutableDictionary *internalBatchConversionResult;
@property (nonatomic, retain) NSMutableDictionary *internalBatchConversionQueue;
@property (nonatomic, retain) ASINetworkQueue *batchRequestQueue;
@property (nonatomic, retain) ASIHTTPRequest *internalConversionRequest;
@property (nonatomic, retain) NSError *internalError;
@property (nonatomic, retain) NSString *internalFromCurrency;
@property (nonatomic, retain) NSString *internalToCurrency;

- (ASIHTTPRequest *)createRequestWithParameters:(NSArray *)parameters isBatchRequest:(BOOL)isBatchRequest isAsynchronous:(BOOL)isAsynchronous;
- (void)updateBatchResult:(NSString *)yahooResponse forCurrencies:(NSArray *)currencies;
@end

@implementation YFCurrencyConverter
@synthesize delegate;
@synthesize internalError;
@synthesize internalConversionRequest;
@synthesize internalBatchConversionResult;
@synthesize internalFromCurrency;
@synthesize internalToCurrency;
@synthesize batchRequestQueue;
@synthesize internalBatchConversionQueue;
@synthesize didFailSelector;
@synthesize didFinishSelector;
@dynamic error;
@dynamic conversionRate;
@dynamic fromCurrency;
@dynamic toCurrency;
@dynamic batchConversionRates;


#pragma mark - Initializers

+ (YFCurrencyConverter *)currencyConverterWithDelegate:(id<NSObject>)delegate
{
    return [[[self alloc] initWithDelegate:delegate] autorelease];
}

- (id)initWithDelegate:(id<NSObject>)aDelegate
{
    if((self = [super init])) {
        self.delegate = aDelegate;
        
        if (delegate != nil) {
            didFinishSelector = @selector(currencyConversionDidFinish:);
            didFailSelector = @selector(currencyConversionDidFail:);
        }
    }
    return self;
}

#pragma mark - Private methods

- (ASIHTTPRequest *)createRequestWithParameters:(NSArray *)parameters isBatchRequest:(BOOL)isBatchRequest isAsynchronous:(BOOL)isAsynchronous
{
    NSString *requestParameter = @"";
    
    int paramCount = [parameters count];
    for (int i = 0; i < paramCount; i++) {
        requestParameter = [requestParameter stringByAppendingFormat:@"&s=%@%@=X", [[parameters objectAtIndex:i] firstValue], [[parameters objectAtIndex:i] secondValue]];
    }
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://quote.yahoo.com/d/quotes.csv?f=l1%@",requestParameter]]];
    request.cachePolicy = ASIDoNotReadFromCacheCachePolicy;
    
    if (!isBatchRequest) {
        request.delegate = self;
        [request setDidFailSelector:@selector(conversionDidFail:)];
        [request setDidFinishSelector:@selector(conversionDidFinish:)];
    }
    else if (isBatchRequest && !isAsynchronous) {
        request.delegate = self;
        [request setDidFailSelector:@selector(batchRequestDidFail:)];
    }
    
    return request;
}


- (void)updateBatchResult:(NSString *)yahooResponse forCurrencies:(NSArray *)currencies
{
    NSArray *results = [yahooResponse componentsSeparatedByString: @"\n"];
    
    int resultCount = [results count];
    int currencyCount = [currencies count];
    for (int i = 0; i < resultCount && i < currencyCount; i++) {
        YFTwoValueObject *fromto = [currencies objectAtIndex:i];
        NSNumber *rate = [NSNumber numberWithFloat:[[results objectAtIndex:i] floatValue]];
        
        if ([self.internalBatchConversionResult valueForKey:(NSString *)fromto.firstValue] == nil) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:rate forKey:(NSString*)fromto.secondValue];
            [self.internalBatchConversionResult setObject:dict forKey:(NSString *)fromto.firstValue];
        }
        else {
            [[self.internalBatchConversionResult objectForKey:(NSString*)fromto.firstValue] setObject:rate forKey:(NSString*)fromto.secondValue];
        }
    }
}

#pragma mark - Public methods

- (void)convertFromCurrency:(NSString *)fromCurrency_ toCurrency:(NSString *)toCurrency_ asynchronous:(BOOL)asyncronous
{
    [self cancel];
    
    self.internalFromCurrency = fromCurrency_;
    self.internalToCurrency = toCurrency_;

    self.internalConversionRequest = [self createRequestWithParameters:[NSArray arrayWithObject:[YFTwoValueObject objectWithValues:self.internalFromCurrency second:self.internalToCurrency]] isBatchRequest:NO isAsynchronous:asyncronous];
    
    if (asyncronous) {
        [self.internalConversionRequest startAsynchronous];
    }
    else {
        [self.internalConversionRequest startSynchronous];
    }
}


- (void)convertFromCurrencies:(NSArray *)fromCurrencies toCurrencies:(NSArray *)toCurrencies asychronous:(BOOL)asynchronous
{
    [self cancel];
    
    if (asynchronous) {
        self.batchRequestQueue = [ASINetworkQueue queue];
        self.internalBatchConversionQueue = [NSMutableDictionary dictionary];
    }

    self.internalBatchConversionResult = [NSMutableDictionary dictionary];
    
    NSMutableArray *currencyChunk = [NSMutableArray array];
    int chunkCounter = 0;
    
    for (NSString *from in fromCurrencies) {
        for (NSString *to in toCurrencies) {
            
            YFTwoValueObject *fromto = [YFTwoValueObject objectWithValues:from second:to];
            [currencyChunk addObject:fromto];
            chunkCounter++;
            
            // The service can only take an URL of ~2000 chars. If we're at 170 conversions in one go we're getting
            // close to 2000 chars and need to run multiple requests.
            if (chunkCounter >= 170) {
                ASIHTTPRequest *request = [self createRequestWithParameters:currencyChunk isBatchRequest:YES isAsynchronous:asynchronous];
                if (asynchronous) {
                    [self.batchRequestQueue addOperation:request];
                    [self.internalBatchConversionQueue setValue:currencyChunk forKey:[[request url] absoluteString]];
                }
                else {
                    [request startSynchronous];
                    if (request.error != nil) {
                        return;
                    }
                    else {
                        [self updateBatchResult:[request responseString] forCurrencies:currencyChunk];
                    }
                }
                
                currencyChunk = [NSMutableArray array];
                chunkCounter = 0;                    
            }
        }
    }
    
    if (chunkCounter > 0) {
        ASIHTTPRequest *request = [self createRequestWithParameters:currencyChunk isBatchRequest:YES isAsynchronous:asynchronous];
        if (asynchronous) {
            [self.batchRequestQueue addOperation:request];
            [self.internalBatchConversionQueue setValue:currencyChunk forKey:[[request url] absoluteString]];
        }
        else {
            [request startSynchronous];
            if (request.error != nil) {
                return;
            }
            else {
                [self updateBatchResult:[request responseString] forCurrencies:currencyChunk];
            }
        }
    }
    
    if (asynchronous) {
        self.batchRequestQueue.delegate = self;
        self.batchRequestQueue.shouldCancelAllRequestsOnFailure = YES;
        self.batchRequestQueue.queueDidFinishSelector = @selector(batchQueueDidFinish:);
        self.batchRequestQueue.requestDidFinishSelector = @selector(batchRequestDidFinish:);
        [self.batchRequestQueue go];        
    }

}

- (void)cancel
{
    [self.batchRequestQueue reset];
    self.batchRequestQueue = nil;
    self.internalBatchConversionQueue = nil;
    self.internalBatchConversionResult = nil;
    
    [self.internalConversionRequest clearDelegatesAndCancel];
    self.internalConversionRequest = nil;
    self.internalFromCurrency = nil;
    self.internalToCurrency = nil;
    self.internalError = nil;
}

#pragma mark - ASIHttpRequest delegate methods

- (void)conversionDidFinish:(ASIHTTPRequest *)request
{
    internalConversionRate = [[self.internalConversionRequest responseString] floatValue];
    self.internalConversionRequest = nil;
    
    if (self.didFinishSelector && [self.delegate respondsToSelector:self.didFinishSelector]) {
        [self.delegate performSelector:self.didFinishSelector withObject:self];        
    }
}

- (void)conversionDidFail:(ASIHTTPRequest *)request
{
    self.internalError = request.error;
    self.internalConversionRequest = nil;
    
    if (self.didFailSelector && [self.delegate respondsToSelector:self.didFailSelector]) {
        [self.delegate performSelector:self.didFailSelector withObject:self];        
    }
}

- (void)batchQueueDidFinish:(ASINetworkQueue *)queue
{
    [self.batchRequestQueue reset];
    self.batchRequestQueue = nil;
    
    if (self.didFinishSelector && [self.delegate respondsToSelector:self.didFinishSelector]) {
        [self.delegate performSelector:self.didFinishSelector withObject:self];        
    }
}

- (void)batchRequestDidFinish:(ASIHTTPRequest *)request
{
    NSArray *currencies = [self.internalBatchConversionQueue valueForKey:[request.originalURL absoluteString]];     
    [self updateBatchResult:[request responseString] forCurrencies:currencies];
}
                     
- (void)batchRequestDidFail:(ASIHTTPRequest *)request
{
    NSError *error = request.error;
    
    // cancel cleans things up
    [self cancel];
    self.internalError = error;
    
    if (self.didFailSelector && [self.delegate respondsToSelector:self.didFailSelector]) {
        [self.delegate performSelector:self.didFailSelector withObject:self];        
    }
}

#pragma mark - Accessors

- (NSError *)error
{
    return self.internalError;
}

- (float)conversionRate
{
    return internalConversionRate;
}

- (NSString *)fromCurrency
{
    return self.internalFromCurrency;
}

- (NSString *)toCurrency
{
    return self.internalToCurrency;
}

- (NSDictionary *)batchConversionRates
{
    // We return nil until all requests have completed
    if (self.batchRequestQueue != nil) {
        return nil;
    }
    else {
        return self.internalBatchConversionResult;
    }
}

#pragma mark - Memory management
- (void)dealloc
{
    [self cancel];   
    [super dealloc];
}
@end
