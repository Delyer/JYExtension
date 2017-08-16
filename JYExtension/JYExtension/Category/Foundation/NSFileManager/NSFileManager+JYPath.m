//
//  NSFileManager+JYPath.m
//  JYExtension
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSFileManager+JYPath.h"

@implementation NSFileManager (JYPath)

+ (NSString *)getDirHome{
    return NSHomeDirectory();
}
+ (NSString *)getDirDocumentsPath{
    return [self getPathForDirectory:NSDocumentDirectory];
}
+ (NSString *)getDirLibraryPath{
     return [self getPathForDirectory:NSLibraryDirectory];
    
}
+ (NSString *)getDirCachePath{
    return [self getPathForDirectory:NSCachesDirectory];
}
+ (NSString *)getDirTmpPath{
    return NSTemporaryDirectory();
}

+ (NSString *)getPathForDirectory:(NSSearchPathDirectory)directory{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (BOOL)fileExistsAtPath:(NSString *)path{
    return [[self defaultManager] fileExistsAtPath:path];
}

+ (NSArray *)getSubpathsAtPath:(NSString *)path{
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] subpathsAtPath:path];
    }
    return nil;
}

+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)path{
    NSError *error;
    if ([self fileExistsAtPath:path]) {
        NSArray *fileArray = [[self defaultManager] contentsOfDirectoryAtPath:path error:&error];
        if (!error) {
            return fileArray;
        }else{
            NSLog(@"getContentsOfDirectoryAtPath error:%@",error);
        }
    }
    return nil;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path dirName:(NSString *)dirName{
    
    if ([self fileExistsAtPath:path]) {
        NSString *newDirectory = [path stringByAppendingPathComponent:dirName];
        // 创建目录
        BOOL res=[[self defaultManager] createDirectoryAtPath:newDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        return res;
    }else{
        NSLog(@"the path is not exist！");
    }
    return NO;
}


+ (BOOL)createFileAtPath:(NSString *)path fileName:(NSString *)fileName{
    
    if ([self fileExistsAtPath:path]) {
        NSString *newFile = [path stringByAppendingPathComponent:fileName];
        if ([self fileExistsAtPath:newFile]) {
            NSLog(@"Duplicate creation is not required， because the file is already exist! ");
            return YES;
        }
        // 创建文件
        BOOL res=[[self defaultManager] createFileAtPath:newFile contents:nil attributes:nil];
        return res;
    }else{
        NSLog(@"the path is not exist！");
    }
    return NO;
}

//写文件
+ (BOOL)writeWithData:(NSData *)data toPath:(NSString *)path fileName:(NSString *)fileName{
    if ([self fileExistsAtPath:path]) {
        NSString *newFile = [path stringByAppendingPathComponent:fileName];
        return [data writeToFile:newFile atomically:YES];
    }
    return NO;
}

+ (NSData *)readFileAtPath:(NSString *)path{
    BOOL isDir = NO;
    if ([[self defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        if (!isDir) {
             NSData *data = [NSData dataWithContentsOfFile:path];
            return data;
        }
    }
    return nil;
}

+ (BOOL)deleteFileOrDicAtPath:(NSString *)path{
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] removeItemAtPath:path error:nil];
    }
    return YES;
}


+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath{
    if ([self fileExistsAtPath:srcPath]) {
        return [[self defaultManager] moveItemAtPath:srcPath toPath:dstPath error:nil];
    }
    return NO;
}

+ (BOOL)copyItemAtPath:(NSString *)scrPath toPath:(NSString *)dstPath{
    if ([self fileExistsAtPath:scrPath]) {
        return [[self defaultManager] copyItemAtPath:scrPath toPath:dstPath error:nil];
    }
    return NO;
}

@end
