//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "DetailsViewController.h"


@interface DetailsViewController()
@property (nonatomic, retain) YFStockDetailsLoader *detailsLoader;
@property (nonatomic, retain) NSArray *detailKeys;
@end

@implementation DetailsViewController
@synthesize stockDetails;
@synthesize stockSymbol;
@synthesize detailsLoader;
@synthesize detailKeys;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.title = self.stockSymbol.name;
    self.detailsLoader = [YFStockDetailsLoader loaderWithDelegate:self];
    [self.detailsLoader loadDetails:self.stockSymbol.symbol];
}

#pragma mark - YFStockDetailsLoader delegate methods

- (void)stockDetailsDidLoad:(YFStockDetailsLoader *)aDetailsLoader
{    
    self.detailKeys = [aDetailsLoader.stockDetails.detailsDictionary allKeys];
    [self.stockDetails reloadData];
}

- (void)stockDetailsDidFail:(YFStockDetailsLoader *)aDetailsLoader
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Details failed" 
                                                    message:[aDetailsLoader.error localizedDescription] 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark - UITableView delegate methods
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.detailKeys != nil) {
        return [self.detailKeys count];
    }
    
    return 4;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (self.detailsLoader.stockDetails == nil && indexPath.row == 2) {
        cell.textLabel.text = @"Retrieving details, please wait...";
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    else if ([self.detailKeys count] > 0) {
        cell.textLabel.textColor = [UIColor blackColor];
        NSString *str = [self.detailsLoader.stockDetails.detailsDictionary objectForKey:[self.detailKeys objectAtIndex:indexPath.row]];
        if (![[NSNull null] isEqual:str]) {
            cell.detailTextLabel.text = str;             
        }
        else {
            cell.detailTextLabel.text = @"N/A";
        }
        cell.textLabel.text = [self.detailKeys objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    }
    else {
        cell.textLabel.text = @"";
    }
    
    return cell;
}



#pragma mark - Memory management
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.detailsLoader cancel];
    
    self.detailKeys = nil;
    self.detailsLoader = nil;
    self.stockSymbol = nil;
    self.stockDetails = nil;
    [super dealloc];
}

@end
