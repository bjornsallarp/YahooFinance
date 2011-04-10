//
//  Created by Björn Sållarp on 2011-04-09.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@class YFCurrencyConverter;

@interface YFCurrencyConverter : NSObject {
    NSMutableDictionary *internalBatchConversionQueue;
    NSMutableDictionary *internalBatchConversionResult;
    ASINetworkQueue *batchRequestQueue;
    ASIHTTPRequest *internalConversionRequest;
    NSError *internalError;
    float internalConversionRate;
    NSString *internalFromCurrency;
    NSString *internalToCurrency;
    
    SEL didFinishSelector;
    SEL didFailSelector;
}

@property (nonatomic, assign) id<NSObject> delegate;
@property (nonatomic, readonly) NSError *error;
@property (nonatomic, readonly) NSString *fromCurrency;
@property (nonatomic, readonly) NSString *toCurrency;
@property (nonatomic, readonly) float conversionRate;
@property (nonatomic, readonly) NSDictionary *batchConversionRates;
@property (assign) SEL didFinishSelector;
@property (assign) SEL didFailSelector;

+ (YFCurrencyConverter *)currencyConverterWithDelegate:(id<NSObject>)delegate;
- (id)initWithDelegate:(id<NSObject>)delegate;
- (void)convertFromCurrency:(NSString *)fromCurrency toCurrency:(NSString *)toCurrency asynchronous:(BOOL)asyncronous;
- (void)convertFromCurrencies:(NSArray *)fromCurrencies toCurrencies:(NSArray *)toCurrencies asychronous:(BOOL)asynchronous;
- (void)cancel;

@end
