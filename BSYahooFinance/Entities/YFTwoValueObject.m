//
//  Created by Björn Sållarp on 2011-04-10.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "YFTwoValueObject.h"

@implementation YFTwoValueObject
@synthesize firstValue, secondValue;

+ (id)objectWithValues:(NSObject *)first second:(NSObject *)second
{
    return [[[self alloc] initWithValues:first second:second] autorelease];
}

- (id)initWithValues:(NSObject *)first second:(NSObject *)second
{
    if((self = [super init])) {
        self.firstValue = first;
        self.secondValue = second;
    }
    return self;
}

- (void)dealloc
{
    self.firstValue = nil;
    self.secondValue = nil;
    [super dealloc];
}
@end
