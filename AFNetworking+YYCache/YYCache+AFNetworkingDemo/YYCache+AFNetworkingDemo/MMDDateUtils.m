//
//  MMDDateUtils.m
//  MeMeDaiSteward
//
//  Created by Mime97 on 16/1/25.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDDateUtils.h"
#import "AppDelegate.h"

@implementation MMDDateUtils

+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)date formatter:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    //为了避免时区问题
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    return [dateFormatter dateFromString:date];
}

+ (NSDate *)getNowDate:(NSString *)format {
    return [self dateFromString:[self stringFromDate:[MMDDateUtils getTimesDate] formatter:format] formatter:format];
}

+ (NSString *)getCurrDate:(NSString *)format {
    return [self stringFromDate:[MMDDateUtils getTimesDate] formatter:format];
}

+ (NSDate *)getPrevDayFromDate:(NSDate *) date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    NSDate *currDate = [calendar dateFromComponents:components];
    NSDate *prevDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:currDate options:0];
    return prevDate;
}

+ (NSInteger)calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd {
    NSInteger unitFlags = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [cal components:unitFlags fromDate:inBegin];
    NSDate *newBegin  = [cal dateFromComponents:comps];
    NSCalendar *cal2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps2 = [cal2 components:unitFlags fromDate:inEnd];
    NSDate *newEnd  = [cal2 dateFromComponents:comps2];
    NSTimeInterval interval = [newBegin timeIntervalSinceDate:newEnd];
    NSInteger beginDays = ((NSInteger)interval)/(3600*24);
    return beginDays;
}

+ (NSString *)diffTimeWithCompareDate:(NSString *)compareDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:yyyyMMddHHmm];//设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    //指定日期
    NSDate *assignDate = [formatter dateFromString:compareDate];
    NSTimeInterval timeInterval = [assignDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"1分钟内"];
    } else if ((temp = timeInterval/60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
    } else if ((temp = temp/60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前", temp];
    } else if ((temp = temp/24) < 30) {
        result = [NSString stringWithFormat:@"%ld天前", temp];
    } else if ((temp = temp/30) < 12) {
        result = [NSString stringWithFormat:@"%ld个月前", temp];
    } else {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前", temp];
    }
    return  result;
}

+ (NSString *)getTimestamp {
    return [NSString stringWithFormat:@"%ld", time(NULL)*1000];
}

+ (NSDate *)getTimesDate {
    // 修改默认时区会影响时间的输出显示
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]]; // 只能够修改该程序的defaultTimeZone，不能修改系统的，更不能修改其他程序的。
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [NSDate date];
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    NSDate *date = [dateFormatter dateFromString:nowDateString];
    return date;
}

+ (NSString *)getTimeFromTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:yyyy_MM_dd];
    NSString *formatteredDate = [formatter stringFromDate:date];
    return formatteredDate;
}

+ (NSString *)getAccurateTimeFromTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:yyyyMMddHHmm];
    NSString *formatteredDate = [formatter stringFromDate:date];
    return formatteredDate;
}

@end
