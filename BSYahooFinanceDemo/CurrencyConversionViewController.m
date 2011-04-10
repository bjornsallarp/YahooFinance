//
//  Created by Björn Sållarp on 2011-04-10.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "CurrencyConversionViewController.h"
#import "BSYahooFinance.h"

@interface CurrencyConversionViewController()
@property (nonatomic, retain) NSArray *currencyList;
@property (nonatomic, retain) NSDictionary *currencyRateMatrix;
@property (nonatomic, retain) YFCurrencyConverter *currencyConversion; 

- (NSArray *)loadCurrencies;
- (void)updateResult;
@end

@implementation CurrencyConversionViewController
@synthesize conversionResult, amount, currencyList, currencyConversion;
@synthesize fromCurrency, toCurrency, currencyRateMatrix;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *allCurrencies = [self loadCurrencies];
    self.currencyConversion = [YFCurrencyConverter currencyConverterWithDelegate:self];
    self.currencyConversion.didFailSelector = @selector(currencyConversionDidFail:);
    self.currencyConversion.didFinishSelector = @selector(currencyConversionDidFinish:);
    [self.currencyConversion convertFromCurrencies:allCurrencies toCurrencies:allCurrencies asychronous:YES];
    
    self.amount.text = @"100";
    self.conversionResult.text = @"Retrieving conversion rates..";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Close the text input keyboard if the user touch the view
    UITouch *touch = [touches anyObject];
    if(touch.tapCount == 1 && [self.amount isFirstResponder]) {
        [self.amount resignFirstResponder];
    }
}

#pragma mark - YFCurrencyConverter delegate methods

- (void)currencyConversionDidFinish:(YFCurrencyConverter *)converter
{
    self.currencyRateMatrix = converter.batchConversionRates;
    self.currencyList = [self loadCurrencies];
    [self.fromCurrency reloadAllComponents];
    [self.toCurrency reloadAllComponents];
    
    [self updateResult];
    
    self.currencyConversion = nil;
}

- (void)currencyConversionDidFail:(YFCurrencyConverter *)converter
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Details failed" 
                                                    message:[converter.error localizedDescription] 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark - Private methods
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

    // Returns sorted array
    return [[tempDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)updateResult
{
    if (self.currencyList) {
        NSString *from = [self.currencyList objectAtIndex:[self.fromCurrency selectedRowInComponent:0]];
        NSString *to = [self.currencyList objectAtIndex:[self.toCurrency selectedRowInComponent:0]];
        
        float rate = [[[self.currencyRateMatrix valueForKey:from] valueForKey:to] floatValue];
        
        self.conversionResult.text = [NSString stringWithFormat:@"%@ %@ -> %@ = %.03f\r\nRate: %.03f", self.amount.text, from, to, [self.amount.text floatValue] * rate, rate];
    }

}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.amount.text isEqualToString:@""]) {
        self.amount.text = @"100";
    }
    
    [self updateResult];
}

#pragma mark - UIPickerView delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.currencyList objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self updateResult];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [self.currencyList count];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.currencyConversion cancel];
    
    self.currencyList = nil;
    self.currencyRateMatrix = nil;
    self.currencyList = nil;
    self.conversionResult = nil;
    self.amount = nil;
    self.fromCurrency = nil;
    self.toCurrency = nil;
    
    [super dealloc];
}

@end
