//
//  HLFileManager.m
//  JHLTools
//
//  Created by heartjhl on 2019/6/23.
//  Copyright © 2019 heartjhl. All rights reserved.
//

#import "HLFileManager.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/param.h>
#include <sys/mount.h>

@interface HLFileManager ()

@end
@implementation HLFileManager

+ (NSString *)filePathAtRootPath:(NSString *)rootPath fileName:(NSString *)fileName{
    return [rootPath stringByAppendingPathComponent:fileName];
}

+ (NSString *)filePathInDocumentsWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath{
    
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    documentPath = [documentPath stringByAppendingPathComponent:dirPath];
    
    if (filePath&&filePath.length>0) {
        documentPath = [documentPath stringByAppendingPathComponent:filePath];
    }
    
    return documentPath;
}

+ (NSString *)filePathInLibraryWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath{
    
    NSString * libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    libraryPath = [libraryPath stringByAppendingPathComponent:dirPath];
    
    if (filePath&&filePath.length>0) {
        libraryPath = [libraryPath stringByAppendingPathComponent:filePath];
    }
    
    return libraryPath;
}

+ (NSString *)filePathInCacheWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath{
    
    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachesPath = [cachesPath stringByAppendingPathComponent:dirPath];
    
    if (filePath&&filePath.length>0) {
        cachesPath = [cachesPath stringByAppendingPathComponent:filePath];
    }
    
    return cachesPath;
}

+ (NSString *)filePathInTemWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath{
    
    NSString *temPath = NSTemporaryDirectory();
    temPath = [temPath stringByAppendingPathComponent:dirPath];
    
    if (filePath&&filePath.length>0) {
        temPath = [temPath stringByAppendingPathComponent:filePath];
    }
    
    return temPath;
}

+ (BOOL)isExistFileAtPath:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /**
     path:用于判断该路径下文件夹或者文件是否存在
     isDir:用于文件夹或者文件存在的情况下，判断该路径是文件夹路径还是文件路径
     
     文件夹或者文件不存在时isDir为NO，存在的情况下，若为文件夹路径isDir为YES，若为文件路径isDir为NO
     */
    BOOL isDir = NO;
    BOOL isExisted = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    
    return (isExisted == YES) && (isDir == NO);
}

+ (BOOL)isExistDirAtPath:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExisted = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    
    return (isExisted == YES) && (isDir == YES);
}

+ (BOOL)isExistFile:(NSString *)fileName AtPath:(NSString *)path{
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return [HLFileManager isExistFileAtPath:filePath];
}

+ (BOOL)isExistDir:(NSString *)dirName AtPath:(NSString *)path{
    
    NSString *filePath = [path stringByAppendingPathComponent:dirName];
    
    return [HLFileManager isExistDirAtPath:filePath];
}

+ (unsigned long long)fileSizeWithInDirectFolderAtPath:(NSString *)path{
    return 10;
}

+ (NSString *)totalFilesSizeAtPath:(NSString *)path{
    
    NSString *sizeStr = @"";
    BOOL isExistDir = [HLFileManager isExistDirAtPath:path];
    if (isExistDir) {//该路径为文件夹路径
        
        //深遍历文件夹 subPaths:包括文件夹路径和文件路径
        NSArray *subPaths = [self listFilesInDirectoryAtPath:path deep:YES];
        NSEnumerator *contentsEnumurator = [subPaths objectEnumerator];
        NSString *file;
        unsigned long long int folderSize = 0;
        /**
         路径为文件夹路径时，只计算该文件夹的大小，不计算该文件夹内文件或者文件夹的大小。
         */
        while (file = [contentsEnumurator nextObject]) {
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:nil];
            folderSize += [[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue];
        }
        NSNumber *size = [NSNumber numberWithUnsignedLongLong:folderSize];
        if (size) {
            /*NSByteCountFormatterCountStyle枚举
             *NSByteCountFormatterCountStyleFile 字节为单位，采用十进制的1000bytes = 1KB
             *NSByteCountFormatterCountStyleMemory 字节为单位，采用二进制的1024bytes = 1KB
             *NSByteCountFormatterCountStyleDecimal KB为单位，采用十进制的1000bytes = 1KB
             *NSByteCountFormatterCountStyleBinary KB为单位，采用二进制的1024bytes = 1KB
             */
            sizeStr = [NSByteCountFormatter stringFromByteCount:[size unsignedLongLongValue] countStyle:NSByteCountFormatterCountStyleFile];
        }
        
    }else if ([HLFileManager isExistFileAtPath:path]){//该路径为文件路径
        //计算文件的大小
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        unsigned long long int folderSize = [[fileAttributes objectForKey:NSFileSize] intValue];//单位字节，采用十进制
        //     folderSize:1000   folderSize/1000 = 1KB
        NSNumber *size = [NSNumber numberWithUnsignedLongLong:folderSize];
        if (size) {
        sizeStr = [NSByteCountFormatter stringFromByteCount:[size unsignedLongLongValue] countStyle:NSByteCountFormatterCountStyleFile];
        }
        
        
    }else{//路径不存在
        
    }
    
    return sizeStr;
}


/**
 文件遍历
 参数1：目录的绝对路径
 参数2：是否深遍历 (1. 浅遍历：返回当前目录下的所有文件和文件夹；
 2. 深遍历：返回当前目录下及子目录下的所有文件和文件夹)
 */
+ (NSArray *)listFilesInDirectoryAtPath:(NSString *)path deep:(BOOL)deep {
    NSArray *listArr;
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (deep) {
        // 深遍历
        NSArray *deepArr = [manager subpathsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = deepArr;
        }else {
            listArr = nil;
        }
    }else {
        // 浅遍历
        NSArray *shallowArr = [manager contentsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = shallowArr;
        }else {
            listArr = nil;
        }
    }
    return listArr;
}

//+ (BOOL)isArriveUpperLimitAtPaths:(NSArray *)paths WithUpperLimitByByte:(unsigned long long)upperLimit{
//
//}
//
//+ (BOOL)isArriveUpperLimitAtPaths:(NSArray *)paths WithUpperLimitByKByte:(unsigned long long)upperLimit{
//
//}
//
//+ (BOOL)isArriveUpperLimitAtPaths:(NSArray *)paths WithUpperLimitByMByte:(unsigned long long)upperLimit{
//
//}

+ (NSString *)createDir:(NSString *)path{
    BOOL isExistDir = [HLFileManager isExistDirAtPath:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isCreateSuccess = YES;
    if (!isExistDir) {
       isCreateSuccess = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSAssert(isCreateSuccess == YES, @"文件夹路径创建失败");
    
    return path;
}

+ (NSString *)filePathWithDirPath:(NSString *)path fileName:(NSString *)fileName{
    return [self filePathWithDirPath:path fileName:fileName deleteFile:NO];;
}

+ (NSString *)filePathWithDirPath:(NSString *)path fileName:(NSString *)fileName deleteFile:(BOOL)isDelete{
    NSString *filePath = [[self createDir:path] stringByAppendingPathComponent:fileName];
    if (isDelete) {
//        删除filePath对应的文件，如filePath：xxx/123.png，若图片存在则删除该图片
        unlink([filePath UTF8String]);
    }
    return filePath;
}

-(BOOL)writeToFile:(NSString *)path withString:(NSString *)contentStr{
    NSError *error;
    BOOL isSave = [contentStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return isSave;
}

-(BOOL)writeToFile:(NSString *)path withData:(NSData *)data{
//    BOOL isSave = [data writeToFile:path options:0 error:&error];
    BOOL isSave = [data writeToFile:path atomically:YES];
    return isSave;
}

-(BOOL)createFileAtPath:(NSString *)path contentsData:(nullable NSData *)data attributes:(nullable NSDictionary<NSFileAttributeKey, id> *)attr{
   return [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:attr];
}

-(BOOL)writeToFile:(NSString *)path withArray:(NSArray *)contentArray{
    BOOL isSave = [contentArray writeToFile:path atomically:YES];
    return isSave;
}

-(BOOL)writeToFile:(NSString *)path withDictionary:(NSDictionary *)contentDic{
    BOOL isSave = [contentDic writeToFile:path atomically:YES];
    return isSave;
}

+ (BOOL)deletePath:(NSString *)path{
   NSError *error;
   BOOL removeSuccess = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    return removeSuccess;
}

+ (BOOL)movePath:(NSString *)path toPath:(NSString *)toPath{
   NSError *error;
   BOOL moveSuccess = [[NSFileManager defaultManager] moveItemAtPath:path toPath:toPath error:&error];
    return moveSuccess;
}

+ (BOOL)copyPath:(NSString *)path toPath:(NSString *)toPath{
    NSError *error;
    BOOL copySuccess = [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:&error];
    return copySuccess;
}

+ (BOOL)linkItemAtPath:(NSString *)path toPath:(NSString *)toPath{
    NSError *error;
    BOOL copySuccess = [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:&error];
    return copySuccess;
}

+ (NSString *)md5File:(NSString *)file{
    
//   NSData *data = [[NSFileManager defaultManager] contentsAtPath:file];
    const char* cStr = [file UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    
    return ret;
}

///第一种方式
+ (float)fileSystemFreeSize{
    
    /// 总大小
    float totalsize = 0.0;
    /// 剩余大小
    float freesize = 0.0;
    /// 是否登录
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary){
        
        NSNumber *freeSpace = [dictionary objectForKey:NSFileSystemFreeSize];
        freesize = [freeSpace unsignedLongLongValue]*1.0/1000/1000/1000;
        
        NSNumber *totalSpace = [dictionary objectForKey:NSFileSystemSize];
        totalsize = [totalSpace unsignedLongLongValue]*1.0/1000/1000/1000;
    } else{
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return freesize;
}

///第二种方式
+ (NSString *)freeDiskSpaceInBytes{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    NSString *str = [NSString stringWithFormat:@"手机剩余存储空间为：%0.2f MB",freeSpace*1.0/1000/1000/1000];
    return str;
}



@end
