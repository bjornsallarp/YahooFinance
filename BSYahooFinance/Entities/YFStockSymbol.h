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


@interface YFStockSymbol : NSObject {
    NSString *symbol;
    NSString *name;
    NSString *currency;
}
@property (nonatomic, retain) NSString *symbol;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *currency;

@end
