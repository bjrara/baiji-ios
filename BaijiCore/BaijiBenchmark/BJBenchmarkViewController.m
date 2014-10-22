//
//  BJBenchmarkViewController.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/22/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJBenchmarkViewController.h"
#import "BJSerializerBenchmark.h"

@interface BJBenchmarkViewController ()

@property (nonatomic, readwrite, retain) NSMutableArray *types;
@property (nonatomic, readwrite, retain) NSMutableDictionary *results;
@property (nonatomic, readwrite, retain) BJSerializerBenchmark *benchmark;

@end

@implementation BJBenchmarkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _types = [[NSMutableArray alloc] init];
    _results = [[NSMutableDictionary alloc] init];
    _benchmark = [[BJSerializerBenchmark alloc] init];
    
    [self benchmarkSerializer:[[[BJJsonSerializerBenchmark alloc] init] autorelease]];
    [self benchmarkSerializer:[[[BJAppleJsonSerializerBenchmark alloc] init] autorelease]];
    [self benchmarkSerializer:[[[BJSBJsonSerializerBenchmark alloc] init] autorelease]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.results count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSString *type = [self.types objectAtIndex:indexPath.section];
    NSArray *array = [self.results objectForKey:type];
    
    switch ((indexPath.row % 6) / 2) {
        case 0:
            cell.textLabel.text = @"BaijiJSON";
            break;
        case 1:
            cell.textLabel.text = @"NSJSONSerialization";
            break;
        case 2:
            cell.textLabel.text = @"SBJSON";
            break;
        default:
            break;
    }

    for (int i = 0; i < [array count]; i++) {
        NSDictionary *data = [array objectAtIndex:i];
        [data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([key isEqual: cell.textLabel.text]) {
                switch (indexPath.row % 2) {
                    case 0: {
                        float writingResult = [[obj objectForKey:@"write"] floatValue];
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"write: %f", writingResult];
                        break;
                    }
                    case 1: {
                        float readingResult = [[obj objectForKey:@"read"] floatValue];
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"read: %f", readingResult];
                        break;
                    }
                    default:
                        break;
                }
                *stop = YES;
            }
        }];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.types objectAtIndex:section];
}

- (void)serializer:(NSString *)serializer didFinish:(NSString *)type writing:(float)writingResult reading:(float)readingResult {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:2];
    [data setObject:[NSNumber numberWithFloat:writingResult] forKey:@"write"];
    [data setObject:[NSNumber numberWithFloat:readingResult] forKey:@"read"];
    NSMutableArray *array = [self.results objectForKey:type];
    if (array) {
        [array addObject:[NSDictionary dictionaryWithObject:data forKey:serializer]];
    } else {
        array = [[NSMutableArray alloc] init];
        [array addObject:[NSDictionary dictionaryWithObject:data forKey:serializer]];
        [self.results setObject:array forKey:type];
        [array release];
        [self.types addObject:type];
    }
    [self.tableView reloadData];
}

- (void)benchmarkSerializer:(id<BJBenchmarkCandidateDelegate>)serializer {
    [serializer setMasterDelegate:self];
    self.benchmark.serializerDelegate = serializer;
    [self.benchmark batch];
}

- (void)dealloc {
    [self.benchmark release];
    [self.types release];
    [self.results release];
    [super dealloc];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
