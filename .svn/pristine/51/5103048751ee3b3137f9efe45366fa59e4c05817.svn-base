//
//  AYHCustomComboBox.m
//  TestCustomComboBox
//
//  Created by AlimysoYang on 12-4-25.
//  Copyright (c) 2012年 __Alimyso Software Ltd__. All rights reserved.
//	QQ:86373007

#import "AYHCustomComboBox.h"
#import "PhoneNumberInfo.h"

@implementation AYHCustomComboBox

@synthesize ccbtableView, ccbListData;//, ccbTitle;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame DataCount:(int)count NotificationName:(NSString *)notificationName
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        NotificationName = [[NSString alloc] initWithString:notificationName];
        ccbListData = [[NSMutableArray alloc] initWithCapacity:0];
        //ccbTitle = [[NSString alloc] initWithString:@""];
        ccbtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [ccbtableView setDelegate:self];
        [ccbtableView setDataSource:self];
        [ccbtableView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:ccbtableView];
        [self setBackgroundColor:[UIColor grayColor]];
        self.layer.cornerRadius = 6.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithRed:192.0f / 255.0f green:126.0f / 255.0f blue:39.0f / 255.0f alpha:1.0f].CGColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) addItemData:(NSString *)itemData
{
	[ccbListData addObject:itemData];    
}

- (void) addItemsData:(NSArray *)itemsData
{
    //[ccbListData addObjectsFromArray:itemsData];
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSMutableArray *array = [NSMutableArray arrayWithArray:itemsData];
    for (int i = 0; i < array.count; i ++) {
        
        
        PhoneNumberInfo *phoneNumberInfo=array[i];
        //NSString *string = array[i];  //2014 04 01
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:phoneNumberInfo];
        
        for (int j = i+1; j < array.count; j ++) {
         
            PhoneNumberInfo *phoneNumberInfo1=array[j];
            // NSString *jstring = array[j];
            
            if([phoneNumberInfo.phoneNumber isEqualToString:phoneNumberInfo1.phoneNumber]){

                [tempArray addObject:phoneNumberInfo1];
            }

        }
    if ([tempArray count] > 1) {
            
            [dateMutablearray addObject:tempArray];
            
            [array removeObjectsInArray:tempArray];
            
            i -= 1;    //去除重复数据 新数组开始遍历位置不变
            
        }
        
        
        
    }
    [ccbListData addObjectsFromArray:dateMutablearray];
    
    
}

- (NSString*) getItemData
{
    return @"";
    //return ccbTitle;
}

- (void) flushData
{
    [self.ccbtableView reloadData];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ccbListData count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewCellHeight;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"CustomComboBoxCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    
    PhoneNumberInfo *phoneNumberInfo=[ccbListData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = phoneNumberInfo.phoneNumber;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhoneNumberInfo *phoneNumberInfo=[ccbListData objectAtIndex:indexPath.row];
    
    NSString* selectItem = phoneNumberInfo.phoneNumber;
    
    //协议执行
    [delegate CustomComboBoxChanged:self SelectedItem:selectItem];
    //通知消息返回
    //[[NSNotificationCenter defaultCenter] postNotificationName:NotificationName object:nil];
}

//- (void) dealloc
//{
//    [NotificationName release];
//    //[ccbTitle release];
//    [ccbListData release];
//    [ccbtableView release];
//    [super dealloc];
////}
@end
