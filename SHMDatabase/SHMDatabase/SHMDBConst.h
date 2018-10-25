//
//  SHMDBConst.h
//  SHMDatabase
//
//  Created by teason23 on 2018/10/25.
//  Copyright © 2018年 teason23. All rights reserved.
//
#import "SHMDatabaseSDK.h"

#ifndef SHMDBConst_h
#define SHMDBConst_h

#define XTFMDBLog1(format, ...)              \
do {                                     \
fprintf(stderr, "🌙🌙🌙xtfmdb🌙🌙🌙\n");   \
(NSLog)((format), ##__VA_ARGS__);    \
fprintf(stderr, "🌙🌙🌙xtfmdb🌙🌙🌙\n\n"); \
} while (0)

#define XTFMDBLog(format, ...)               \
if (SHMDB_isDebug) {                    \
XTFMDBLog1((format), ##__VA_ARGS__); \
};

#endif /* SHMDBConst_h */
