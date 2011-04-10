//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//
#import "BSYahooFinanceAppDelegate.h"

@implementation BSYahooFinanceAppDelegate


@synthesize window=_window;
@synthesize navigationController=_navigationController;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window addSubview:[self.tabBarController view]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    self.tabBarController = nil;
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
