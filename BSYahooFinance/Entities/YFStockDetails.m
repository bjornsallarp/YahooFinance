//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "YFStockDetails.h"

@implementation YFStockDetails
@synthesize detailsDictionary;

#pragma mark - Initializers

+ (YFStockDetails *)stockDetailsWithDetails:(NSDictionary *)details
{
    return [[[self alloc] initWithDetails:details] autorelease];
}

- (id)initWithDetails:(NSDictionary *)detailsDictionary_
{
    if ((self = [super init])) {
        self.detailsDictionary = detailsDictionary_;
    }
    
    return self;
}

#pragma mark - Accessors

- (NSString *)symbol {
    return [self.detailsDictionary valueForKey:@"symbol"];
}
- (NSString *)ask {
    return [self.detailsDictionary valueForKey:@"Ask"];
}
- (NSString *)averageDailyVolume {
    return [self.detailsDictionary valueForKey:@"AverageDailyVolume"];
}
- (NSString *)bid {
    return [self.detailsDictionary valueForKey:@"Bid"];
}
- (NSString *)askRealtime {
    return [self.detailsDictionary valueForKey:@"AskRealtime"];
}
- (NSString *)bidRealtime {
    return [self.detailsDictionary valueForKey:@"BidRealtime"];
}
- (NSString *)bookValue {
    return [self.detailsDictionary valueForKey:@"BookValue"];
}
- (NSString *)changePercentChange {
    return [self.detailsDictionary valueForKey:@"Change_PercentChange"];
}
- (NSString *)change {
    return [self.detailsDictionary valueForKey:@"Change"];
}
- (NSString *)commission {
    return [self.detailsDictionary valueForKey:@"Commission"];
}
- (NSString *)changeRealtime {
    return [self.detailsDictionary valueForKey:@"ChangeRealtime"];
}
- (NSString *)afterHoursChangeRealtime {
    return [self.detailsDictionary valueForKey:@"AfterHoursChangeRealtime"];
}
- (NSString *)dividendShare {
    return [self.detailsDictionary valueForKey:@"DividendShare"];
}
- (NSString *)lastTradeDate {
    return [self.detailsDictionary valueForKey:@"LastTradeDate"];
}
- (NSString *)tradeDate {
    return [self.detailsDictionary valueForKey:@"TradeDate"];
}
- (NSString *)earningsShare {
    return [self.detailsDictionary valueForKey:@"EarningsShare"];
}
- (NSString *)errorIndicationreturnedforsymbolchangedinvalid{
    return [self.detailsDictionary valueForKey:@"ErrorIndicationreturnedforsymbolchangedinvalid"];
}
- (NSString *)EPSEstimateCurrentYear{
    return [self.detailsDictionary valueForKey:@"EPSEstimateCurrentYear"];
}
- (NSString *)EPSEstimateNextYear{
    return [self.detailsDictionary valueForKey:@"EPSEstimateNextYear"];
}
- (NSString *)EPSEstimateNextQuarter{
    return [self.detailsDictionary valueForKey:@"EPSEstimateNextQuarter"];
}
- (NSString *)daysLow{
    return [self.detailsDictionary valueForKey:@"DaysLow"];
}
- (NSString *)daysHigh{
    return [self.detailsDictionary valueForKey:@"DaysHigh"];
}
- (NSString *)yearLow{
    return [self.detailsDictionary valueForKey:@"YearLow"];
}
- (NSString *)yearHigh{
    return [self.detailsDictionary valueForKey:@"YearHigh"];
}
- (NSString *)holdingsGainPercent{
    return [self.detailsDictionary valueForKey:@"HoldingsGainPercent"];
}
- (NSString *)annualizedGain{
    return [self.detailsDictionary valueForKey:@"AnnualizedGain"];
}
- (NSString *)holdingsGain{
    return [self.detailsDictionary valueForKey:@"HoldingsGain"];
}
- (NSString *)holdingsGainPercentRealtime{
    return [self.detailsDictionary valueForKey:@"HoldingsGainPercentRealtime"];
}
- (NSString *)holdingsGainRealtime {
    return [self.detailsDictionary valueForKey:@"HoldingsGainRealtime"];
}
- (NSString *)moreInfo {
    return [self.detailsDictionary valueForKey:@"MoreInfo"];
}
- (NSString *)orderBookRealtime {
    return [self.detailsDictionary valueForKey:@"OrderBookRealtime"];
}
- (NSString *)marketCapitalization {
    return [self.detailsDictionary valueForKey:@"MarketCapitalization"];
}
- (NSString *)marketCapRealtime {
    return [self.detailsDictionary valueForKey:@"MarketCapRealtime"];
}
- (NSString *)EBITDA {
    return [self.detailsDictionary valueForKey:@"EBITDA"];
}
- (NSString *)changeFromYearLow {
    return [self.detailsDictionary valueForKey:@"ChangeFromYearLow"];
}
- (NSString *)percentChangeFromYearLow {
    return [self.detailsDictionary valueForKey:@"PercentChangeFromYearLow"];
}
- (NSString *)lastTradeRealtimeWithTime {
    return [self.detailsDictionary valueForKey:@"LastTradeRealtimeWithTime"];
}
- (NSString *)changePercentRealtime {
    return [self.detailsDictionary valueForKey:@"ChangePercentRealtime"];
}
- (NSString *)changeFromYearHigh {
    return [self.detailsDictionary valueForKey:@"ChangeFromYearHigh"];
}
- (NSString *)percentChangeFromYearHigh {
    // NOTE: Misspelled from source
    return [self.detailsDictionary valueForKey:@"PercebtChangeFromYearHigh"];
}
- (NSString *)lastTradeWithTime {
    return [self.detailsDictionary valueForKey:@"LastTradeWithTime"];
}
- (NSString *)lastTradePriceOnly {
    return [self.detailsDictionary valueForKey:@"LastTradePriceOnly"];
}
- (NSString *)highLimit {
    return [self.detailsDictionary valueForKey:@"HighLimit"];
}
- (NSString *)lowLimit {
    return [self.detailsDictionary valueForKey:@"LowLimit"];
}
- (NSString *)daysRange {
    return [self.detailsDictionary valueForKey:@"DaysRange"];
}
- (NSString *)daysRangeRealtime {
    return [self.detailsDictionary valueForKey:@"DaysRangeRealtime"];
}
- (NSString *)fiftydayMovingAverage {
    return [self.detailsDictionary valueForKey:@"FiftydayMovingAverage"];
}
- (NSString *)twoHundreddayMovingAverage {
    return [self.detailsDictionary valueForKey:@"TwoHundreddayMovingAverage"];
}
- (NSString *)changeFromTwoHundreddayMovingAverage {
    return [self.detailsDictionary valueForKey:@"ChangeFromTwoHundreddayMovingAverage"];
}
- (NSString *)percentChangeFromTwoHundreddayMovingAverage {
    return [self.detailsDictionary valueForKey:@"PercentChangeFromTwoHundreddayMovingAverage"];
}
- (NSString *)changeFromFiftydayMovingAverage {
    return [self.detailsDictionary valueForKey:@"ChangeFromFiftydayMovingAverage"];
}
- (NSString *)percentChangeFromFiftydayMovingAverage {
    return [self.detailsDictionary valueForKey:@"PercentChangeFromFiftydayMovingAverage"];
}
- (NSString *)name {
    return [self.detailsDictionary valueForKey:@"Name"];
}
- (NSString *)notes {
    return [self.detailsDictionary valueForKey:@"Notes"];
}
- (NSString *)open {
    return [self.detailsDictionary valueForKey:@"Open"];
}
- (NSString *)previousClose {
    return [self.detailsDictionary valueForKey:@"PreviousClose"];
}
- (NSString *)pricePaid {
    return [self.detailsDictionary valueForKey:@"PricePaid"];
}
- (NSString *)changeinPercent {
    return [self.detailsDictionary valueForKey:@"ChangeinPercent"];
}
- (NSString *)priceSales {
    return [self.detailsDictionary valueForKey:@"PriceSales"];
}
- (NSString *)priceBook {
    return [self.detailsDictionary valueForKey:@"PriceBook"];
}
- (NSString *)exDividendDate {
    return [self.detailsDictionary valueForKey:@"ExDividendDate"];
}
- (NSString *)PERatio {
    return [self.detailsDictionary valueForKey:@"PERatio"];
}
- (NSString *)dividendPayDate {
    return [self.detailsDictionary valueForKey:@"DividendPayDate"];
}
- (NSString *)PERatioRealtime {
    return [self.detailsDictionary valueForKey:@"PERatioRealtime"];
}
- (NSString *)PEGRatio {
    return [self.detailsDictionary valueForKey:@"PEGRatio"];
}
- (NSString *)priceEPSEstimateCurrentYear {
    return [self.detailsDictionary valueForKey:@"PriceEPSEstimateCurrentYear"];
}
- (NSString *)priceEPSEstimateNextYear {
    return [self.detailsDictionary valueForKey:@"PriceEPSEstimateNextYear"];
}
- (NSString *)sharesOwned {
    return [self.detailsDictionary valueForKey:@"SharesOwned"];
}
- (NSString *)shortRatio {
    return [self.detailsDictionary valueForKey:@"ShortRatio"];
}
- (NSString *)lastTradeTime {
    return [self.detailsDictionary valueForKey:@"LastTradeTime"];
}
- (NSString *)tickerTrend {
    return [self.detailsDictionary valueForKey:@"TickerTrend"];
}
- (NSString *)oneyrTargetPrice {
    return [self.detailsDictionary valueForKey:@"OneyrTargetPrice"];
}
- (NSString *)volume {
    return [self.detailsDictionary valueForKey:@"Volume"];
}
- (NSString *)holdingsValue {
    return [self.detailsDictionary valueForKey:@"HoldingsValue"];
}
- (NSString *)holdingsValueRealtime {
    return [self.detailsDictionary valueForKey:@"HoldingsValueRealtime"];
}
- (NSString *)yearRange {
    return [self.detailsDictionary valueForKey:@"YearRange"];
}
- (NSString *)daysValueChange {
    return [self.detailsDictionary valueForKey:@"DaysValueChange"];
}
- (NSString *)daysValueChangeRealtime {
    return [self.detailsDictionary valueForKey:@"DaysValueChangeRealtime"];
}
- (NSString *)stockExchange {
    return [self.detailsDictionary valueForKey:@"StockExchange"];
}
- (NSString *)dividendYield {
    return [self.detailsDictionary valueForKey:@"DividendYield"];
}
- (NSString *)percentChange {
    return [self.detailsDictionary valueForKey:@"PercentChange"];
}

#pragma mark - Memory management
- (void)dealloc 
{
    self.detailsDictionary = nil;
    [super dealloc];
}
@end
