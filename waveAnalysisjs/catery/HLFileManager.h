//
//  HLFileManager.h
//  JHLTools
//
//  Created by heartjhl on 2019/6/23.
//  Copyright © 2019 heartjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLFileManager : NSObject
/**
 可写入类型
 NSData
 NSString
 NSArray
 NSDictionary
 调用方法
 - (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile
 */
/**
 *  在本地目录下文件的路径
 *  sample：（rootPath：/Users/heartjhl/Desktop/Test，fileName：456）
 *  filePath:/Users/heartjhl/Desktop/Test/456
 *
 *  @param rootPath 根路径
 *  @param fileName  文件名
 *
 *  @return 本地目录下文件的路径
 */
+ (NSString *)filePathAtRootPath:(NSString *)rootPath fileName:(NSString *)fileName;

/**
 *  在Documents文件夹下的路径
 *  sample：（dirPath：123 ，fileName：456）
 * filePath：var/mobile/Containers/Data/Application/517A1EA2-C3DC-4B3A-9E42-32943581FF62/Documents/123/456
 *
 *  @param dirPath  根路径
 *  @param filePath 文件名
 *
 *  @return 本地目录下文件的路径
 */
+ (NSString *)filePathInDocumentsWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath;

/**
 *  在Library文件夹下的路径
 *  filePath：同上
 *
 *  @param dirPath  根路径
 *  @param filePath 文件名
 *
 *  @return 本地目录下文件的路径
 */
+ (NSString *)filePathInLibraryWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath;

/**
 *  在Cache文件夹下的路径
 *  filePath：同上
 *
 *  @param dirPath  根路径
 *  @param filePath 文件名
 *
 *  @return 本地目录下文件的路径
 */
+ (NSString *)filePathInCacheWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath;

/**
 *  在tem文件夹下的路径
 *  filePath：同上
 *
 *  @param dirPath  根路径
 *  @param filePath 文件名
 *
 *  @return 本地目录下文件的路径
 */
+ (NSString *)filePathInTemWithDirPath:(NSString *)dirPath filePath:(NSString *)filePath;

/**
 *  检查路径是否指向文件 (检查路径是否为文件路径)
 *
 *  @param path 文件路径
 *
 *  @return 路径是否指向文件
 */
+ (BOOL)isExistFileAtPath:(NSString *)path;

/**
 *  检查路径是否指向文件夹 (检查路径是否为文件夹路径)
 *
 *  @param path 文件夹路径
 *
 *  @return 路径是否指向文件夹
 */
+ (BOOL)isExistDirAtPath:(NSString *)path;

/**
 *  检查本地路径下是否存在某个文件
 *
 *  @param fileName 文件名
 *  @param path     路径
 *
 *  @return 本地路径下是否存在某个文件
 */
+ (BOOL)isExistFile:(NSString *)fileName AtPath:(NSString *)path;

/**
 *  检查本地路径下是否存在某个文件夹
 *
 *  @param dirName 文件夹
 *  @param path    路径
 *
 *  @return 本地路径下是否存在某个文件夹
 */
+ (BOOL)isExistDir:(NSString *)dirName AtPath:(NSString *)path;


/**
 *  当前路径对应的那一级目录下，除文件夹之外的文件的大小
 *
 *  @param path 目录路径
 *
 *  @return 当前路径对应的那一级目录下，除文件夹之外的文件的大小
 */
+ (unsigned long long)fileSizeWithInDirectFolderAtPath:(NSString *)path;

/**
 *  某个路径下所有文件的大小
 *
 *  @param path 目录路径
 *
 *  @return 某个路径下所有文件的大小
 */
+ (NSString *)totalFilesSizeAtPath:(NSString *)path;

///**
// *  检查是否文件夹大小到达上限
// *
// *  @param paths      目录路径列表
// *  @param upperLimit 上限数 (单位:Byte)
// *
// *  @return 是否文件夹大小到达上限
// */
//+ (BOOL)isArriveUpperLimitAtPaths:(NSArray *)paths WithUpperLimitByByte:(unsigned long long)upperLimit;
//
///**
// *  检查是否文件夹大小到达上限
// *
// *  @param paths      目录路径列表
// *  @param upperLimit 上限数 (单位:KByte)
// *
// *  @return 是否文件夹大小到达上限
// */
//+ (BOOL)isArriveUpperLimitAtPaths:(NSArray *)paths WithUpperLimitByKByte:(unsigned long long)upperLimit;
//
///**
// *  检查是否文件夹大小到达上限
// *
// *  @param paths      目录路径列表
// *  @param upperLimit 上限数 (单位:MByte)
// *
// *  @return 是否文件夹大小到达上限
// */
//+ (BOOL)isArriveUpperLimitAtPaths:(NSArray *)paths WithUpperLimitByMByte:(unsigned long long)upperLimit;

/**
 *  创建文件夹 （写入内容的时候创建文件夹，其他的如移动，复制等不需要创建，系统会在移动，复制的时候自动创建）
 *
 *  @param path 路径
 *
 *  @return 创建文件夹路径
 */
+ (NSString *)createDir:(NSString *)path;

/**
 *  文件路径
 *
 *  @param path 路径
 *  @param fileName 文件名 123.png，123.mov，123.wav
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithDirPath:(NSString *)path fileName:(NSString *)fileName;

/**
 *  内容存入指定文件
 *
 *  @param path 路径 如：xxx/xxx.txt
 *  @param contentStr 存入的内容为字符串
 *
 *  @return 是否存入成功
 */
-(BOOL)writeToFile:(NSString *)path withString:(NSString *)contentStr;

/**
 *  内容存入指定文件
 *
 *  @param path 路径 如：xxx/xxx.png,xxx/xxx.mvo等
 *  @param data 存入的内容为二进制数据
 *
 *  @return 是否存入成功
 */
-(BOOL)writeToFile:(NSString *)path withData:(NSData *)data;

/**
 *  把data存入path
 *
 *  @param path 路径 如：xxx/xxx.png,xxx/xxx.mvo等
 *  @param data 存入的内容为二进制数据
 *  @param attr 属性
 *
 *  @return 是否存入成功
 */
-(BOOL)createFileAtPath:(NSString *)path contentsData:(nullable NSData *)data attributes:(nullable NSDictionary<NSFileAttributeKey, id> *)attr;

/**
 *  内容存入指定文件
 *
 *  @param path 路径 如：xxx/xxx.plist
 *  @param contentArray 存入的内容为数组
 *
 *  @return 是否存入成功
 */
-(BOOL)writeToFile:(NSString *)path withArray:(NSArray *)contentArray;

/**
 *  内容存入指定文件
 *
 *  @param path 路径 如：xxx/xxx.plist
 *  @param contentDic 存入的内容为字典
 *
 *  @return 是否存入成功
 */
-(BOOL)writeToFile:(NSString *)path withDictionary:(NSDictionary *)contentDic;

/**
 *  文件路径
 *
 *  @param path 路径
 *  @param fileName 文件名 123.png，123.mov，123.wav
 *  @param isDelete 是否删除文件路径对应的文件
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithDirPath:(NSString *)path fileName:(NSString *)fileName deleteFile:(BOOL)isDelete;

/**
 *  在本地删除路径,路径是文件则删除该文件，是文件夹路径则删除该文件夹以及该文件内的数据
 *
 *  @param path 路径
 *
 *  @return 是否被删除
 */
+ (BOOL)deletePath:(NSString *)path;

/**
 *  在本地删除路径
 *
 *  @param paths 路径列表
 */
//+ (void)deletePaths:(NSArray *)paths;

/**
 *  移动文件位置,移动后源路径中就没有了该文件，文件在要移动到的路径中,要移动的文件如果在toPath中已经存在，则移动失败
 *
 *  @param path   源路径
 *  @param toPath 移动路径，不存在时，在移动的时候系统会创建
 *
 *  @return 是否移动成功
 */
+ (BOOL)movePath:(NSString *)path toPath:(NSString *)toPath;

/**
 *  复制文件,把path中的文件复制一份到toPath中,如果toPath已经存在要复制的文件，则复制失败
 *
 *  @param path   源路径
 *  @param toPath 目的路径，不存在时，在复制的时候系统会创建
 *
 *  @return 是否移动成功
 */
+ (BOOL)copyPath:(NSString *)path toPath:(NSString *)toPath;

/**
 *  链接文件,把path中的文件复制一份到toPath中,如果toPath已经存在要复制的文件，则复制失败
 *
 *  @param path   源路径
 *  @param toPath 目的路径，不存在时，在链接的时候系统会创建
 *
 *  @return 是否移动成功
 */
+ (BOOL)linkItemAtPath:(NSString *)path toPath:(NSString *)toPath;

/**
 *  获取文件的MD5
 *
 *  @param file 文件的MD5
 */
+ (NSString *)md5File:(NSString *)file;


/**
 获取手机可用空间（单位：字节）
 
 @return 当前可用空间
 */
+ (float)fileSystemFreeSize;


@end

NS_ASSUME_NONNULL_END
