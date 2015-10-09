//
//  DetailTableViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "DetailTableViewController.h"
#import "POAPinyin.h"

@interface DetailTableViewController ()<UISearchBarDelegate>
{
    NSString * _tempString;
}

@end

@implementation DetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!IsIOS6) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.PCSArr =[[NSMutableArray alloc] initWithCapacity:38];
    self.dataSourceDic = [[NSMutableDictionary alloc] initWithCapacity:38];
    self.PCSPinYinArr =[[NSMutableArray alloc] initWithCapacity:38];
    if (self.dataSourceType == DataSouceType_province) {
        for (int i = 0; i < self.dataSourceArr.count ; i ++ ) {
            ProvinceDO * provinceDO =[self.dataSourceArr objectAtIndex:i];
            [self.PCSArr addObject:provinceDO.provinceName];
            _tempString =[POAPinyin convert:provinceDO.provinceName];
            [self.PCSPinYinArr addObject:_tempString];
            [self.dataSourceDic setObject:provinceDO.provinceName forKey:_tempString];
        }
    } else if (self.dataSourceType == DataSouceType_city) {
        for (int i = 0; i < self.dataSourceArr.count ; i ++ ) {
            CityDO * cityDO =[self.dataSourceArr objectAtIndex:i];
            [self.PCSArr addObject:cityDO.cityName];
            _tempString =[POAPinyin convert:cityDO.cityName];
            [self.PCSPinYinArr addObject:_tempString];
            [self.dataSourceDic setObject:cityDO.cityName forKey:_tempString];
        }
    } else if (self.dataSourceType == DataSouceType_subbranch) {
        for (int i = 0; i < self.dataSourceArr.count ; i ++ ) {
            SubbranchDO * subbranchDO =[self.dataSourceArr objectAtIndex:i];
            [self.PCSArr addObject:subbranchDO.subbranchName];
            _tempString =[POAPinyin convert:subbranchDO.subbranchName];
            [self.PCSPinYinArr addObject:_tempString];
            [self.dataSourceDic setObject:subbranchDO.subbranchName forKey:_tempString];
        }
    }
}

- (void)filterContentForSearchText: (NSString *)searchText
{
    if ([self isValidateLetter:searchText]) {
        [self.searchResults removeAllObjects];
        NSPredicate * resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[search] %@",[searchText uppercaseString]];
        NSArray * tempArr = [self.PCSPinYinArr filteredArrayUsingPredicate:resultPredicate];
        for (int i = 0; i < tempArr.count; i++) {
            [self.searchResults addObject:[self.dataSourceDic objectForKey:[tempArr objectAtIndex:i]]];
        }
    } else {
        NSPredicate * resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[search] %@",searchText];
        self.searchResults = [[self.PCSArr filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    }
}

-(BOOL)isValidateLetter:(NSString *)letter {
    NSString *letterRegex = @"^[A-Za-z]+$";
    NSPredicate *letterTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", letterRegex];
    return [letterTest evaluateWithObject:letter];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView ) {
        return self.dataSourceArr.count;
    } else {
        return self.searchResults.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (tableView == self.tableView) {
        cell.textLabel.text = [self.PCSArr objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (self.dataSourceType == DataSouceType_province) {
            if ([self.delegate respondsToSelector:@selector(didSelectProvince:)]) {
                
                [self.delegate didSelectProvince:[self.dataSourceArr objectAtIndex:indexPath.row]];
            }
        } else if (self.dataSourceType ==  DataSouceType_city) {
            if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
                [self.delegate didSelectCity:[self.dataSourceArr objectAtIndex:indexPath.row]];
            }
        } else if (self.dataSourceType ==  DataSouceType_subbranch) {
            if ([self.delegate respondsToSelector:@selector(didSelectSubbranch:)]) {
                [self.delegate didSelectSubbranch:[self.dataSourceArr objectAtIndex:indexPath.row]];
            }
        }
    } else {
        if (self.dataSourceType == DataSouceType_province) {
            for (int i = 0; i < self.dataSourceArr.count ; i ++ ) {
                ProvinceDO * provinceDO =[self.dataSourceArr objectAtIndex:i];
                if ([provinceDO.provinceName isEqualToString:[self.searchResults objectAtIndex:indexPath.row]]) {
                    if ([self.delegate respondsToSelector:@selector(didSelectProvince:)]) {
                        [self.delegate didSelectProvince:provinceDO];
                    }
                    break;
                }
            }
        } else if (self.dataSourceType == DataSouceType_city) {
            for (int i = 0; i < self.dataSourceArr.count ; i ++ ) {
                CityDO * cityDO =[self.dataSourceArr objectAtIndex:i];
                if ([cityDO.cityName isEqualToString:[self.searchResults objectAtIndex:indexPath.row]]) {
                    if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
                        [self.delegate didSelectCity:cityDO];
                    }
                    break;
                }
            }
        } else if (self.dataSourceType == DataSouceType_subbranch) {
            for (int i = 0; i < self.dataSourceArr.count ; i ++ ) {
                SubbranchDO * subbranchDO =[self.dataSourceArr objectAtIndex:i];
                if ([subbranchDO.subbranchName isEqualToString:[self.searchResults objectAtIndex:indexPath.row]]) {
                    if ([self.delegate respondsToSelector:@selector(didSelectSubbranch:)]) {
                        [self.delegate didSelectSubbranch:subbranchDO];
                    }
                    break;
                }
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
