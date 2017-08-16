//
//  NSDate+JYHandle.m
//  JYExtension
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSDate+JYHandle.h"

@implementation NSDate (JYHandle)

/****************************************************
 *@Description:根据年份、月份、日期、小时数、分钟数、秒数返回NSDate
 *@Params:
 *  year:年份
 *  month:月份
 *  day:日期
 *  hour:小时数
 *  minute:分钟数
 *  second:秒数
 *@Return:
 ****************************************************/
+ (NSDate *)dateWithYear:(NSUInteger)year
                   Month:(NSUInteger)month
                     Day:(NSUInteger)day
                    Hour:(NSUInteger)hour
                  Minute:(NSUInteger)minute
                  Second:(NSUInteger)second {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if (timeIntervalInMilliSecond > 1400000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

/**
 计算两个时间戳的差值(fromDateStr 到toDateStr的时间差)
 */
+ (NSTimeInterval)timeDifferenceFromDate:(NSString *)fromDateStr toDate:(NSString *)toDateStr {
    NSDate *beginDate = [NSDate dateWithTimeIntervalSince1970:[fromDateStr doubleValue]];
    NSTimeInterval beginInterval = [beginDate timeIntervalSince1970];
    
    NSDate *finishDate = [NSDate dateWithTimeIntervalSince1970:[toDateStr doubleValue]];
    NSTimeInterval finishInterval = [finishDate timeIntervalSince1970];
    
    NSTimeInterval timeDifference = finishInterval - beginInterval;
    return timeDifference;
}

+ (NSTimeInterval)timeIntervalSince1970 {
    NSDate *date = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return [localeDate timeIntervalSince1970];
}

+ (NSInteger)intervalDaySinceNow:(NSString *)theDate {
    
    NSDate *d = [self dateWithYYYYMMddHHmmss:theDate];
    NSTimeInterval late = [d timeIntervalSince1970] * 1;
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970] * 1;
    NSString *timeString = @"";
    
    NSTimeInterval cha = now - late;
    if (cha / 86400 > 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 86400];
        timeString = [timeString substringToIndex:timeString.length - 7];
        return [timeString integerValue];
    }
    return -1;
}

+ (NSInteger)intervalMinuteSinceNow:(NSString *)theDate {
    NSDate *d = [self dateWithYYYYMMddHHmmss:theDate];
    NSTimeInterval late = [d timeIntervalSince1970] * 1;
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970] * 1;
    NSString *timeString = @"";
    
    NSTimeInterval cha = now - late;
    if (cha / 60 > 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 60];
        timeString = [timeString substringToIndex:timeString.length - 7];
        return [timeString integerValue];
    }
    return -1;
}

- (NSDate *)convertToLocal {
    NSTimeZone *sourc = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSTimeZone *desti = [NSTimeZone localTimeZone];
    NSTimeInterval interval = [desti secondsFromGMT] - [sourc secondsFromGMT];
    return [self dateByAddingTimeInterval:interval];
}

/****************************************************
 *Description:根据YYYY-MM-dd字符串返回NSDate
 *@Params:
 *  YYYY—MM-dd格式的字符串
 *@Return:
 ****************************************************/
+ (NSDate *)dateWithYYYYMMdd:(NSString *)YYYYMMdd {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMdd] dateFromString:YYYYMMdd];
}

/****************************************************
 *Description:根据YYYY-MM-dd HH:mm:ss字符串返回NSDate
 *@Params:
 *  YYYY—MM-dd HH:mm:ss格式的字符串
 *@Return:
 ****************************************************/
+ (NSDate *)dateWithYYYYMMddHHmmss:(NSString *)YYYYMMddHHmmss {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddHHmmss] dateFromString:YYYYMMddHHmmss];
}

/****************************************************
 *@Description:实现dateFormatter单例方法
 *@Params:nil
 *Return:相应格式的NSDataFormatter对象
 ****************************************************/
+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmss {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMdd {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"yyyy-MM-dd"];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmm {
    static NSDateFormatter *staticDateFormatterWithFormatMMddHHmm;
    if (!staticDateFormatterWithFormatMMddHHmm) {
        staticDateFormatterWithFormatMMddHHmm = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmm setDateFormat:@"MM-dd HH:mm"];
        [staticDateFormatterWithFormatMMddHHmm setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return staticDateFormatterWithFormatMMddHHmm;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatHHmm {
    static NSDateFormatter *staticDateFormatterWithFormatHHmm;
    if (!staticDateFormatterWithFormatHHmm) {
        staticDateFormatterWithFormatHHmm = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatHHmm setDateFormat:@"HH:mm"];
        [staticDateFormatterWithFormatHHmm setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return staticDateFormatterWithFormatHHmm;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmInChinese {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmssInChines) {
        staticDateFormatterWithFormatYYYYMMddHHmmssInChines = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmssInChines setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        [staticDateFormatterWithFormatYYYYMMddHHmmssInChines setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddInChinese {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddInChines;
    if (!staticDateFormatterWithFormatYYYYMMddInChines) {
        staticDateFormatterWithFormatYYYYMMddInChines = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddInChines setDateFormat:@"yyyy年MM月dd日"];
        [staticDateFormatterWithFormatYYYYMMddInChines setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return staticDateFormatterWithFormatYYYYMMddInChines;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmmInChinese {
    static NSDateFormatter *staticDateFormatterWithFormatMMddHHmmInChinese;
    if (!staticDateFormatterWithFormatMMddHHmmInChinese) {
        staticDateFormatterWithFormatMMddHHmmInChinese = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmmInChinese setDateFormat:@"MM月dd日 HH:mm"];
        [staticDateFormatterWithFormatMMddHHmmInChinese setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return staticDateFormatterWithFormatMMddHHmmInChinese;
}

/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents *)componentsOfDay {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
}
//  --------------------------NSDate---------------------------
/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)year {
    return [self componentsOfDay].year;
}

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)month {
    return [self componentsOfDay].month;
}

/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)day {
    return [self componentsOfDay].day;
}

/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)hour {
    return [self componentsOfDay].hour;
}

/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)minute {
    return [self componentsOfDay].minute;
}

/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)second {
    return [self componentsOfDay].second;
}

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)weekday {
    return [self componentsOfDay].weekday;
}

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)weekOfDayInYear {
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

/****************************************************
 *@Description:获得一般当天的工作开始时间
 *@Params:nil
 *@Return:一般当天的工作开始时间
 ****************************************************/
- (NSDate *)workBeginTime {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:9];
    [components setMinute:30];
    [components setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/****************************************************
 *@Description:获得一般当天的工作结束时间
 *@Params:nil
 *@Return:一般当天的工作结束时间
 ****************************************************/
- (NSDate *)workEndTime {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:18];
    [components setMinute:0];
    [components setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/****************************************************
 *@Description:获取一小时后的时间
 *@Params:nil
 *@Return:一小时后的时间
 ****************************************************/
- (NSDate *)oneHourLater {
    return [NSDate dateWithTimeInterval:3600 sinceDate:self];
}

/****************************************************
 *@Description:获得某一天的这个时刻
 *@Params:nil
 *@Return:某一天的这个时刻
 ****************************************************/
- (NSDate *)sameTimeOfDate {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:[[NSDate date] hour]];
    [components setMinute:[[NSDate date] minute]];
    [components setSecond:[[NSDate date] second]];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)sameDayWithDate:(NSDate *)otherDate {
    if (self.year == otherDate.year && self.month == otherDate.month && self.day == otherDate.day) {
        return YES;
    }
    else {
        return NO;
    }
}

/*****************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)sameWeekWithDate:(NSDate *)otherDate {
    if (self.year == otherDate.year && self.month == otherDate.month && self.weekOfDayInYear == otherDate.weekOfDayInYear) {
        return YES;
    }
    else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)sameMonthWithDate:(NSDate *)otherDate {
    if (self.year == otherDate.year && self.month == otherDate.month) {
        return YES;
    }
    else {
        return NO;
    }
}

/****************************************************
 *@Description:获取时间的字符串格式
 *@Params:nil
 *@Return:时间的字符串格式
 ****************************************************/
- (NSString *)stringOfDateWithFormatYYYYMMddHHmmss {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddHHmmss] stringFromDate:self];
}

- (NSString *)stringOfDateWithFormatYYYYMMdd {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMdd] stringFromDate:self];
}

- (NSString *)stringOfDateWithFormatMMddHHmm {
    return [[NSDate defaultDateFormatterWithFormatMMddHHmm] stringFromDate:self];
}

- (NSString *)stringOfDateWithFormatHHmm {
    return [[NSDate defaultDateFormatterWithFormatHHmm] stringFromDate:self];
}

- (NSString *)stringOfDateWithFormatYYYYMMddHHmmInChinese {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddHHmmInChinese] stringFromDate:self];
}

- (NSString *)stringOfDateWithFormatYYYYMMddInChinese {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddInChinese] stringFromDate:self];
}

- (NSString *)stringOfDateWithFormatMMddHHmmInChinese {
    return [[NSDate defaultDateFormatterWithFormatMMddHHmmInChinese] stringFromDate:self];
}

/*******************************************************
 *根据日期字符串（2014-03-18T04:24:54.363Z）
 *获取NSDate对象
 *******************************************************/
+ (NSDate *)dateFromMongoidRFC3339String:(NSString *)dateString {
    
    static NSDateFormatter *DateFormatter;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        DateFormatter = [[NSDateFormatter alloc] init];
        [DateFormatter setLocale:en_US_POSIX];
        [DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
        [DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    
    NSDate *date = nil;
    if (dateString && dateString.length == 24) {
        NSString *RFC3339String = [dateString substringToIndex:19];
        date = [DateFormatter dateFromString:RFC3339String];
    }
    return date;
}

/**
 根据日期格式 获取 当前时间
 */
+ (NSString *)getCurrentDayStringWithFormat:(NSString *)format {
    NSDate *de = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (format)
        dateFormatter.dateFormat = format;
    else
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *ss = [dateFormatter stringFromDate:de];
    
    return ss;
}

+ (NSDate *)dataFromTimeIntervalSince1970:(long long)timeInterval {
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000.0];
}

+ (NSString *)dateStringWithDate:(NSDate *)date dateFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)dateStringWithFromTimeIntervalSince1970:(long long)timeInterval dateFormate:(NSString *)format {
    NSDate *date = [NSDate dataFromTimeIntervalSince1970:timeInterval];
    
    NSString *dateString = [NSDate dateStringWithDate:date dateFormat:format];
    
    return dateString;
}
@end

