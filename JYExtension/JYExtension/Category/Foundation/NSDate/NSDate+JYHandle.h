//
//  NSDate+JYHandle.h
//  JYExtension
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

/**
 *  日期处理分类
 */

#import <Foundation/Foundation.h>

@interface NSDate (JYHandle)

/**
 *  根据年份、月份、日期、小时数、分钟数、秒数返回NSDate
 *
 *  @param year   年份
 *  @param month  月
 *  @param day    日
 *  @param hour   时
 *  @param minute 分
 *  @param second 秒
 *
 *  @return 日期
 */
+ (NSDate *)dateWithYear:(NSUInteger)year
                   Month:(NSUInteger)month
                     Day:(NSUInteger)day
                    Hour:(NSUInteger)hour
                  Minute:(NSUInteger)minute
                  Second:(NSUInteger)second;

/**
 *  根据YYYY-MM-dd字符串返回NSDate
 *
 *  @param YYYYMMdd YYYY—MM-dd格式的字符串
 *
 *  @return 日期
 */
+ (NSDate *)dateWithYYYYMMdd:(NSString *)YYYYMMdd;

/****************************************************
 *Description:根据YYYY-MM-dd HH:mm:ss字符串返回NSDate
 *@Params:
 *  YYYY—MM-dd HH:mm:ss格式的字符串
 *@Return:
 ****************************************************/
+ (NSDate *)dateWithYYYYMMddHHmmss:(NSString *)YYYYMMddHHmmss;

/**
 计算两个时间戳的差值(fromDateStr 到toDateStr的时间差)
 */
+ (NSTimeInterval)timeDifferenceFromDate:(NSString *)fromDateStr
                                  toDate:(NSString *)toDateStr;

/**
 获取当前距离1970年的时间戳
 */
+ (NSTimeInterval)timeIntervalSince1970;

/**
 计算某个时间与当前时间相差天数
 @Params:
 theDate:指定日期：（YYYY-MM-dd hh:mm:ss）
 */
+ (NSInteger)intervalDaySinceNow:(NSString *)theDate;

/**
 计算某个时间与当前时间相差分数
 @Params:
 theDate:指定日期：（YYYY-MM-dd hh:mm:ss）
 */
+ (NSInteger)intervalMinuteSinceNow:(NSString *)theDate;

/****************************************************
 *@Description:实现dateFormatter单例方法
 *@Params:nil
 *Return:相应格式的NSDataFormatter对象
 ****************************************************/
+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmss;

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMdd;

+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmm;

+ (NSDateFormatter *)defaultDateFormatterWithFormatHHmm;

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmInChinese;

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddInChinese;

+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmmInChinese;

/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents *)componentsOfDay;

/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)year;

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)month;

/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)day;

/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)hour;

/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)minute;

/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)second;

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)weekday;

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)weekOfDayInYear;

/****************************************************
 *@Description:获得一般当天的工作开始时间
 *@Params:nil
 *@Return:一般当天的工作开始时间
 ****************************************************/
- (NSDate *)workBeginTime;

/****************************************************
 *@Description:获得一般当天的工作结束时间
 *@Params:nil
 *@Return:一般当天的工作结束时间
 ****************************************************/
- (NSDate *)workEndTime;

/****************************************************
 *@Description:获取一小时后的时间
 *@Params:nil
 *@Return:一小时后的时间
 ****************************************************/
- (NSDate *)oneHourLater;

/****************************************************
 *@Description:获得某一天的这个时刻
 *@Params:nil
 *@Return:某一天的这个时刻
 ****************************************************/
- (NSDate *)sameTimeOfDate;

/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)sameDayWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)sameWeekWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)sameMonthWithDate:(NSDate *)otherDate;

/****************************************************
 *@Description:获取时间的字符串格式
 *@Params:nil
 *@Return:时间的字符串格式
 ****************************************************/
- (NSString *)stringOfDateWithFormatYYYYMMddHHmmss;

- (NSString *)stringOfDateWithFormatYYYYMMdd;

- (NSString *)stringOfDateWithFormatMMddHHmm;

- (NSString *)stringOfDateWithFormatHHmm;

- (NSString *)stringOfDateWithFormatYYYYMMddHHmmInChinese;

- (NSString *)stringOfDateWithFormatYYYYMMddInChinese;

- (NSString *)stringOfDateWithFormatMMddHHmmInChinese;

- (NSDate *)convertToLocal;

/**
 根据日期字符串（2014-03-18T04:24:54.363Z）
 获取NSDate对象
 */
+ (NSDate *)dateFromMongoidRFC3339String:(NSString *)dateString;

/**
 根据格式获取 时间字符串 ，format 可以为nil
 */
+ (NSString *)getCurrentDayStringWithFormat:(NSString *)format;

/**
 *  通过毫秒数获得日期
 */
+ (NSDate *)dataFromTimeIntervalSince1970:(long long)timeInterval;

/**
 *  根据NSDate转换为字符串
 *
 *  @param format 时间字符串格式
 *  @param date   要转换的NSDate
 *
 *  @return 时间字符串
 */
+ (NSString *)dateStringWithDate:(NSDate *)date dateFormat:(NSString *)format;

/**
 *  距离1970毫秒数时间格式化字符串
 *
 *  @param timeInterval 距离1970的毫秒数
 *  @param format       时间字符串格式
 *
 *  @return 时间字符串
 */
+ (NSString *)dateStringWithFromTimeIntervalSince1970:(long long)timeInterval dateFormate:(NSString *)format;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;


@end
