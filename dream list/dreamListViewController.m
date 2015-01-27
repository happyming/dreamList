//
//  thridviewcontroller.m
//  dream list
//
//  Created by 光明 徐 on 14/12/29.
//  Copyright (c) 2014年 Guangming Xu. All rights reserved.
//

#import "dreamListViewController.h"
#import "addDreamViewController.h"

@interface dreamListViewController ()
@property (nonatomic, strong) NSMutableArray *dreamList;
@end

@implementation dreamListViewController

- (NSMutableArray *)dreamList
{
    if (!_dreamList) {
        _dreamList = [[NSMutableArray alloc] init];
        dreamItem *item1 = [[dreamItem alloc] init];
        item1.dreamName = @"灌篮高手之旅";
        dreamItem *item2 = [[dreamItem alloc] init];
        item2.dreamName = @"iMac 27 5k";
        dreamItem *item3 = [[dreamItem alloc] init];
        item3.dreamName = @"奥迪";
        
        [self.dreamList addObject:item1];
        [self.dreamList addObject:item2];
        [self.dreamList addObject:item3];
    }
    
    return _dreamList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dreamList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dreamList" forIndexPath:indexPath];
    
    // Configure the cell...
    dreamItem *item = self.dreamList[indexPath.row];
    cell.textLabel.text = item.dreamName;
    if (item.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    dreamItem *tappedItem = [self.dreamList objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.dreamList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
    }
}

- (IBAction)unwindList:(UIStoryboardSegue *)segue
{
    NSLog(@"in unwindList");
    addDreamViewController *source = [segue sourceViewController];
    dreamItem *item = source.aNewDream;
    if (item) {
        [self.dreamList addObject:item];
        [self.tableView reloadData];
        NSLog(@"in Item");
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
