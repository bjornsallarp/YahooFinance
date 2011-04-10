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


@interface YFStockDetails : NSObject {
    NSDictionary *detailsDictionary;
}

+ (YFStockDetails *)stockDetailsWithDetails:(NSDictionary *)details;
- (id)initWithDetails:(NSDictionary *)detailsDictionary;

@property (nonatomic, retain) NSDictionary *detailsDictionary; 

@property (nonatomic, readonly) NSString *symbol;
@property (nonatomic, readonly) NSString *ask;
@property (nonatomic, readonly) NSString *averageDailyVolume;
@property (nonatomic, readonly) NSString *bid;
@property (nonatomic, readonly) NSString *askRealtime;
@property (nonatomic, readonly) NSString *bidRealtime;
@property (nonatomic, readonly) NSString *bookValue;
@property (nonatomic, readonly) NSString *changePercentChange;
@property (nonatomic, readonly) NSString *change;
@property (nonatomic, readonly) NSString *commission;
@property (nonatomic, readonly) NSString *changeRealtime;
@property (nonatomic, readonly) NSString *afterHoursChangeRealtime;
@property (nonatomic, readonly) NSString *dividendShare;
@property (nonatomic, readonly) NSString *lastTradeDate;
@property (nonatomic, readonly) NSString *tradeDate;
@property (nonatomic, readonly) NSString *earningsShare;
@property (nonatomic, readonly) NSString *errorIndicationreturnedforsymbolchangedinvalid;
@property (nonatomic, readonly) NSString *EPSEstimateCurrentYear;
@property (nonatomic, readonly) NSString *EPSEstimateNextYear;
@property (nonatomic, readonly) NSString *EPSEstimateNextQuarter;
@property (nonatomic, readonly) NSString *daysLow;
@property (nonatomic, readonly) NSString *daysHigh;
@property (nonatomic, readonly) NSString *yearLow;
@property (nonatomic, readonly) NSString *yearHigh;
@property (nonatomic, readonly) NSString *holdingsGainPercent;
@property (nonatomic, readonly) NSString *annualizedGain;
@property (nonatomic, readonly) NSString *holdingsGain;
@property (nonatomic, readonly) NSString *holdingsGainPercentRealtime;
@property (nonatomic, readonly) NSString *holdingsGainRealtime;
@property (nonatomic, readonly) NSString *moreInfo;
@property (nonatomic, readonly) NSString *orderBookRealtime;
@property (nonatomic, readonly) NSString *marketCapitalization;
@property (nonatomic, readonly) NSString *marketCapRealtime;
@property (nonatomic, readonly) NSString *EBITDA;
@property (nonatomic, readonly) NSString *changeFromYearLow;
@property (nonatomic, readonly) NSString *percentChangeFromYearLow;
@property (nonatomic, readonly) NSString *lastTradeRealtimeWithTime;
@property (nonatomic, readonly) NSString *changePercentRealtime;
@property (nonatomic, readonly) NSString *changeFromYearHigh;
@property (nonatomic, readonly) NSString *percentChangeFromYearHigh;
@property (nonatomic, readonly) NSString *lastTradeWithTime;
@property (nonatomic, readonly) NSString *lastTradePriceOnly;
@property (nonatomic, readonly) NSString *highLimit;
@property (nonatomic, readonly) NSString *lowLimit;
@property (nonatomic, readonly) NSString *daysRange;
@property (nonatomic, readonly) NSString *daysRangeRealtime;
@property (nonatomic, readonly) NSString *fiftydayMovingAverage;
@property (nonatomic, readonly) NSString *twoHundreddayMovingAverage;
@property (nonatomic, readonly) NSString *changeFromTwoHundreddayMovingAverage;
@property (nonatomic, readonly) NSString *percentChangeFromTwoHundreddayMovingAverage;
@property (nonatomic, readonly) NSString *changeFromFiftydayMovingAverage;
@property (nonatomic, readonly) NSString *percentChangeFromFiftydayMovingAverage;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *notes;
@property (nonatomic, readonly) NSString *open;
@property (nonatomic, readonly) NSString *previousClose;
@property (nonatomic, readonly) NSString *pricePaid;
@property (nonatomic, readonly) NSString *changeinPercent;
@property (nonatomic, readonly) NSString *priceSales;
@property (nonatomic, readonly) NSString *priceBook;
@property (nonatomic, readonly) NSString *exDividendDate;
@property (nonatomic, readonly) NSString *PERatio;
@property (nonatomic, readonly) NSString *dividendPayDate;
@property (nonatomic, readonly) NSString *PERatioRealtime;
@property (nonatomic, readonly) NSString *PEGRatio;
@property (nonatomic, readonly) NSString *priceEPSEstimateCurrentYear;
@property (nonatomic, readonly) NSString *priceEPSEstimateNextYear;
@property (nonatomic, readonly) NSString *sharesOwned;
@property (nonatomic, readonly) NSString *shortRatio;
@property (nonatomic, readonly) NSString *lastTradeTime;
@property (nonatomic, readonly) NSString *tickerTrend;
@property (nonatomic, readonly) NSString *oneyrTargetPrice;
@property (nonatomic, readonly) NSString *volume;
@property (nonatomic, readonly) NSString *holdingsValue;
@property (nonatomic, readonly) NSString *holdingsValueRealtime;
@property (nonatomic, readonly) NSString *yearRange;
@property (nonatomic, readonly) NSString *daysValueChange;
@property (nonatomic, readonly) NSString *daysValueChangeRealtime;
@property (nonatomic, readonly) NSString *stockExchange;
@property (nonatomic, readonly) NSString *dividendYield;
@property (nonatomic, readonly) NSString *percentChange;


@end
