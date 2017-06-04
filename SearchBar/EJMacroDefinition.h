//
//  EJMacroDefinition.h
//  kTest
//
//  Created by xiacheng on 16/7/15.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#ifndef EJMacroDefinition_h
#define EJMacroDefinition_h

//是否打开调试  目前影响的是5.
#define DEBUGA


//0. 常用扩展
#import "UIViewExt.h"


//1. 屏幕尺寸
//需要横屏或者竖屏，获取屏幕宽度与高度//??? nativeBounds 是什么
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define kScreenWidth ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define kScreenSize ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize [UIScreen mainScreen].bounds.size
#endif


//2. 获取通知中心
#define EJNotificationCenter [NSNotificationCenter defaultCenter]

//3.设置随机颜色
#define EJRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//4.设置RGB颜色/设置RGBA颜色
#define EJRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define EJRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// clear背景颜色
#define EJClearColor [UIColor clearColor]

//5. 自定义高效率 Log  一个详细，一个是简单

#ifdef DEBUGA
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define SLog(fmt,...) NSLog(fmt,##__VA_ARGS__);
#else
# define DLog(...);
# define SLog(...);
#endif



//6.弱引用/强引用
#define EJWeakSelf(type)  __weak typeof(type) weak##type = type;
#define EJStrongSelf(type)  __strong typeof(type) type = weak##type;


//7.设置 view 圆角和边框
#define EJViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//8.由角度转换弧度 由弧度转换角度
#define EJDegreesToRadian(x) (M_PI * (x) / 180.0)
#define EJRadianToDegrees(radian) (radian*180.0)/(M_PI)

//9.快速创建图片
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//10.获取当前语言
#define EJCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//11.判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

    //判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

    //判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

    // 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

    // 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

    // 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

    //获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

    //判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

//15.判断是真机还是模拟器
#if TARGET_OS_IPHONE
    //iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
    //iPhone Simulator
#endif


//16. 引入头文件
//#ifdef __OBJC__
//#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>
//#endif

////17. 常用三方库
//#import "UIViewExt.h"
//#import "BaseModel.h"

//18. 缩放系数(相对于iphone6)
#define kScaleFactorWidth (kScreenWidth/375.0)
#define kScaleFactorHeight (kScreenHeight/667.0)


//19. 几种常用的颜色

#define kBlueColor EJRGBAColor(45,131,229,1)   //亮蓝色































#endif /* EJMacroDefinition_h */
