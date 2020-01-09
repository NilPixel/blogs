//
//  MMDDateUtils.h
//  MeMeDaiSteward
//
//  Created by Mime97 on 16/1/25.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>

#define yyyy_MM_dd @"yyyy-MM-dd"
#define yyyyMMddHHmm @"yyyy-MM-dd HH:mm"

@interface MMDDateUtils : NSObject

/**
 *  格式化日期
 *  NSDate convert to NSString date
 *
 *  @param date
 *  @param format
 *
 *  @return
 */
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)format;

/**
 *  格式化字符串的时间
 *
 *  @param date
 *  @param format
 *
 *  @return
 */
+ (NSDate *)dateFromString:(NSString *)date formatter:(NSString *)format;

/**
 *  获取当前时间
 *
 *  @param format
 *
 *  @return NSDate
 */
+ (NSDate *)getNowDate:(NSString *)format;

/**
 *  获取当前时间
 *
 *  @param format
 *
 *  @return NSString
 */
+ (NSString *)getCurrDate:(NSString *)format;

/**
 *  根据传入的日期得到前一天日期
 *
 *  @param date
 *
 *  @return
 */
+ (NSDate *)getPrevDayFromDate:(NSDate *) date;

/**
 * 计算两个日期相差的天数
 *
 *  @param inBegin
 *  @param inEnd
 *
 *  @return
 */
+ (NSInteger) calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd;

/**
 *  计算指定时间与当前的时间差
 *
 *  @param compareDate 指定的时间
 *
 *  多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *)diffTimeWithCompareDate:(NSString *)compareDate;

/**
 *  获取时间戳(精确到毫秒)
 *
 *  @return
 */
+ (NSString *)getTimestamp;

/**
 *
 *利用服务器时间与手机时间差,获取服务器时间
 *
 */
+ (NSDate *)getTimesDate;

/**
 *
 *传入一个时间段将其转换为日期格式
 *
 */
+ (NSString *)getTimeFromTimeInterval:(NSTimeInterval)timeInterval;

/**
 *
 *传入一个时间段将其转换为日期格式，精确到秒
 *
 */
+ (NSString *)getAccurateTimeFromTimeInterval:(NSTimeInterval)timeInterval;

@end
