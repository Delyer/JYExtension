//
//  NSFileManager+JYPath.h
//  JYExtension
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (JYPath)

//获取App沙盒根路径：
+ (NSString *)getDirHome;
//获取App_Documents路径
+ (NSString *)getDirDocumentsPath;
//获取App_Library路径
+ (NSString *)getDirLibraryPath;
//获取App_Cache路径
+ (NSString *)getDirCachePath;
//获取App_Tmp根路径
+ (NSString *)getDirTmpPath;

//路径文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path;

//递归获取目录下所有文件名（文件和文件夹）
+ (NSArray *)getSubpathsAtPath:(NSString *)path;
//非递归获取目录下所有文件名（文件和文件夹）
+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)path;

//创建文件夹
+ (BOOL)createDirectoryAtPath:(NSString *)path dirName:(NSString *)dirName;
//创建文件
+ (BOOL)createFileAtPath:(NSString *)path fileName:(NSString *)fileName;

//写文件
+ (BOOL)writeWithData:(NSData *)data toPath:(NSString *)path fileName:(NSString *)fileName;

//读取文件
+ (NSData *)readFileAtPath:(NSString *)path;
//删除文件或文件夹
+ (BOOL)deleteFileOrDicAtPath:(NSString *)path;

//移动文件
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
//复制文件
+ (BOOL)copyItemAtPath:(NSString *)scrPath toPath:(NSString *)dstPath;



@end
