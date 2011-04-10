//
//  Created by Björn Sållarp on 2011-04-10.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <Foundation/Foundation.h>


@interface YFTwoValueObject : NSObject {
    NSObject *firstValue;
    NSObject *secondValue;
}
@property (nonatomic, retain) NSObject *firstValue;
@property (nonatomic, retain) NSObject *secondValue;

+ (id)objectWithValues:(NSObject *)first second:(NSObject *)second;
- (id)initWithValues:(NSObject *)first second:(NSObject *)second;

@end
