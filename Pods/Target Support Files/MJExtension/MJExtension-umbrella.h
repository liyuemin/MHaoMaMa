#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MJConst.h"
#import "MJExtension.h"
#import "MJFoundation.h"
#import "MJIvar.h"
#import "MJType.h"
#import "NSObject+MJCoding.h"
#import "NSObject+MJIvar.h"
#import "NSObject+MJKeyValue.h"

FOUNDATION_EXPORT double MJExtensionVersionNumber;
FOUNDATION_EXPORT const unsigned char MJExtensionVersionString[];

