//
//  Created by Björn Sållarp on 2011-04-10.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSYahooFinanceCurrencyConverter.h"

@implementation BSYahooFinanceCurrencyConverter

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (NSArray *)loadCurrencies
{
    // Load a whole bunch of currencies used for Yahoo stocks. It should be around 20 currencies
    NSDictionary *stockCurrency = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StockExchangeCurrency" ofType:@"plist"]];
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    [tempDict setValue:@"" forKey:@"USD"];
    
    // Filter out so there's only one of each currency
    for (NSString *key in stockCurrency)
    {
        if ([tempDict valueForKey:[stockCurrency valueForKey:key]] == nil)
            [tempDict setValue:@"" forKey:[stockCurrency valueForKey:key]];
    }
    
    return [tempDict allKeys];
}

#pragma mark - delegate methods

- (void)currencyConversionDidFinish:(YFCurrencyConverter *)currencyConverter
{
    didFinishCalled = YES;
}
- (void)currencyConversionDidFail:(YFCurrencyConverter *)currencyConverter
{
    didFailCalled = YES;
}

#pragma mark - Tests
- (void)testSingleConversionAsynchronous 
{
    didFailCalled = NO;
    didFinishCalled = NO;
    
    YFCurrencyConverter *converter = [YFCurrencyConverter currencyConverterWithDelegate:self];
    [converter convertFromCurrency:@"SEK" toCurrency:@"USD" asynchronous:YES];
    
    while (didFailCalled == NO && didFinishCalled == NO)
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
    
    STAssertTrue(didFinishCalled, @"Conversion failed, did fishish wasn't called");
    STAssertFalse((converter.conversionRate > 1.0), @"It's very likely the conversion failed. The day SEK is worth more than USD pigs fly");
}

- (void)testSingleConversionSynchronous 
{
    YFCurrencyConverter *converter = [YFCurrencyConverter currencyConverterWithDelegate:nil];
    [converter convertFromCurrency:@"SEK" toCurrency:@"USD" asynchronous:NO];

    STAssertFalse((converter.conversionRate > 1.0), @"It's very likely the conversion failed. The day SEK is worth more than USD pigs fly");
}

- (void)testMultiConversionAsynchronous 
{
    NSArray *allCurrencies = [self loadCurrencies];
    YFCurrencyConverter *converter = [YFCurrencyConverter currencyConverterWithDelegate:self];
    [converter convertFromCurrencies:allCurrencies toCurrencies:allCurrencies asychronous:YES];
    
    // Wait for asynchronous call to finish
    while (didFailCalled == NO && didFinishCalled == NO)
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
    
    STAssertTrue(didFinishCalled, @"Conversion failed, did fishish wasn't called");
    
    // Count the number of results we get back
    NSDictionary *resultMatrix = converter.batchConversionRates;
    int conversionCount = 0;
    for (NSString *fromCurrency in allCurrencies) {
        conversionCount += [[resultMatrix valueForKey:fromCurrency] count];
    }
    
    int expectedResults = [allCurrencies count] * [allCurrencies count];
    STAssertEquals(conversionCount, expectedResults, @"Conversion didn't return the expected amount of results");
    
    STAssertNotNil([[resultMatrix valueForKey:@"SEK"] valueForKey:@"USD"], @"Missing conversion rate for SEK to USD");
    
    float SEKtoUSDconversion = [[[resultMatrix valueForKey:@"SEK"] valueForKey:@"USD"] floatValue]; 
    STAssertFalse((SEKtoUSDconversion > 1.0), @"It's very likely the conversion failed. The day SEK is worth more than USD pigs fly");
}

- (void)testMultiConversionSynchronous 
{
    NSArray *allCurrencies = [self loadCurrencies];
    YFCurrencyConverter *converter = [YFCurrencyConverter currencyConverterWithDelegate:nil];
    [converter convertFromCurrencies:allCurrencies toCurrencies:allCurrencies asychronous:NO];
    
    // Count the number of results we get back
    NSDictionary *resultMatrix = converter.batchConversionRates;
    int conversionCount = 0;
    for (NSString *fromCurrency in allCurrencies) {
        conversionCount += [[resultMatrix valueForKey:fromCurrency] count];
    }
    
    int expectedResults = [allCurrencies count] * [allCurrencies count];
    STAssertEquals(conversionCount, expectedResults, @"Conversion didn't return the expected amount of results");
    
    STAssertNotNil([[resultMatrix valueForKey:@"SEK"] valueForKey:@"USD"], @"Missing conversion rate for SEK to USD");
    
    float SEKtoUSDconversion = [[[resultMatrix valueForKey:@"SEK"] valueForKey:@"USD"] floatValue]; 
    STAssertFalse((SEKtoUSDconversion > 1.0), @"It's very likely the conversion failed. The day SEK is worth more than USD pigs fly");
}

@end
