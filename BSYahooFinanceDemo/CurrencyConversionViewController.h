//
//  Created by Björn Sållarp on 2011-04-10.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <UIKit/UIKit.h>

@class YFCurrencyConverter;

@interface CurrencyConversionViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
    UILabel *conversionResult;
    UITextField *amount;
    UIPickerView *fromCurrency;
    UIPickerView *toCurrency;
    NSArray *currencyList;
    NSDictionary *currencyRateMatrix;
    YFCurrencyConverter *currencyConversion;
}

@property (nonatomic, retain) IBOutlet UILabel *conversionResult;
@property (nonatomic, retain) IBOutlet UITextField *amount;
@property (nonatomic, retain) IBOutlet UIPickerView *fromCurrency;
@property (nonatomic, retain) IBOutlet UIPickerView *toCurrency;
@end
