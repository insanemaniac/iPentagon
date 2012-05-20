//
//  AddGangsterViewController.m
//  MyGang
//
//  Created by Parag Dulam on 04/02/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "AddGangsterViewController.h"

@implementation AddGangsterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    searchResultArray = [[NSMutableArray alloc] init];
//    tableDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    backButton.hidden = NO;
    searchBar.tintColor = [UIColor grayColor];
    
    
    NSDictionary *usersDictionary = [[NSDictionary alloc] initWithContentsOfFile:[self getUsersDatabasePath]];
    tableDataArray = [[NSMutableArray alloc] initWithArray:[usersDictionary objectForKey:@"Users"]];
    [tableView reloadData];
    [self setTitleString:@"Add a Partner"];
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

-(void)dealloc
{
    [tableDataArray release];
    tableDataArray = nil;
    
    [searchResultArray release];
    searchResultArray = nil;
    [super dealloc];
}
 
#pragma mark
#pragma mark UITableViewDelegate
#pragma mark


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self.searchDisplayController.searchBar.text length]) {
        return [tableDataArray count];
    } else {
        return [searchResultArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:@"Cell"] autorelease];
    }
    cell.textLabel.font = [self getFontForFileName:@"ComicSans" ofType:@"ttf" 
                                          fontsize:16.f];
    if (![self.searchDisplayController.searchBar.text length]) {
        cell.textLabel.text = [[tableDataArray objectAtIndex:indexPath.row] objectForKey:@"Email"];
    } else {
        cell.textLabel.text = [[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"Email"];
    }
    
    
    return cell;
}

//-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.backgroundColor = [UIColor clearColor];
//}

//#pragma mark
//#pragma mark UISearchBarDelegate
//#pragma mark
//
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//    return YES;
//}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    
//}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    return YES;
//}
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    
//}
//- (void)searchBar:(UISearchBar *)sBar textDidChange:(NSString *)searchText
//
//{
//    NSRange r = [sBar.text rangeOfString:searchText options:NSCaseInsensitiveSearch];
//    
//    if(r.location != NSNotFound)
//        
//    {
//        if(r.location== 0)//that is we are checking only the start of the names.
//        {
//            NSLog(@"FOUND");
//        } else {
//        }
//    }
//    
//}
//
//
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)sBar
//{
//    [sBar resignFirstResponder];
//}



#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[searchResultArray removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (NSDictionary *user in tableDataArray)
	{
        NSComparisonResult result = [[user objectForKey:@"Email"] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [searchResultArray addObject:user];
        }
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}





@end
