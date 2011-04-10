//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "YFStockSymbol.h"


@implementation YFStockSymbol
@synthesize symbol, name, currency;

-(void)dealloc
{
    self.symbol = nil;
    self.name = nil;
    self.currency = nil;
    [super dealloc];
}
@end
