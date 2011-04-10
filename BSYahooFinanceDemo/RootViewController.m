//
//  Created by Björn Sållarp on 2011-03-27.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "RootViewController.h"
#import "DetailsViewController.h"

@interface RootViewController()
@property (nonatomic, retain) YFStockSymbolSearch *symbolSearch;
@property (nonatomic, retain) NSArray *stockSymbols;
@end

@implementation RootViewController
@synthesize symbolsSearchView;
@synthesize searchBar;
@synthesize symbolSearch;
@synthesize stockSymbols;

- (void)viewDidLoad
{
    self.title = @"Search stocks";
    self.symbolSearch = [YFStockSymbolSearch symbolSearchWithDelegate:self];
    [super viewDidLoad];
}


#pragma mark - YFStockSymbolSearch delegate methods

- (void)symbolSearchDidFinish:(YFStockSymbolSearch *)symbolFinder
{
    self.stockSymbols = symbolFinder.symbols;
    [self.symbolsSearchView reloadData];
}

- (void)symbolSearchDidFail:(YFStockSymbolSearch *)symbolFinder
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search failed" 
                                                    message:[symbolFinder.error localizedDescription] 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark - UISearchBar delegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText != nil && [searchText length] > 2) {
        [self.symbolSearch findSymbols:searchText];
    }
    else {
        self.stockSymbols = nil;
        [self.symbolsSearchView reloadData];
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    [aSearchBar resignFirstResponder];
}


#pragma mark - UITableView delegate methods
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.stockSymbols != nil  && [self.stockSymbols count] > 0) {
        return [self.stockSymbols count];
    }

    return 4;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.stockSymbols == nil && indexPath.row == 2) {
        cell.textLabel.text = @"Start typing in the search box to find stocks!";
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    else if ([self.stockSymbols count] == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"No stocks match your search";
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    else if ([self.stockSymbols count] > 0) {
        cell.textLabel.textColor = [UIColor blackColor];
        YFStockSymbol *symbol = [self.stockSymbols objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", symbol.name, symbol.symbol];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    else {
        cell.textLabel.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    
    YFStockSymbol *symbol = [self.stockSymbols objectAtIndex:indexPath.row];

    if (symbol) {
        DetailsViewController *detailViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        detailViewController.stockSymbol = [self.stockSymbols objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
    
    [self.symbolsSearchView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Memory management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [self.symbolSearch cancel];
    
    self.stockSymbols = nil;
    self.symbolSearch = nil;
    self.symbolsSearchView = nil;
    self.searchBar = nil;
    [super dealloc];
}

@end
