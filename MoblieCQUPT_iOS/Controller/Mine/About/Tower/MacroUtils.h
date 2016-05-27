// Author: Tang Qiao
// Date:   2012-3-2
//
// The macro is inspired from:
//     http://www.yifeiyang.net/iphone-development-skills-of-the-debugging-chapter-2-save-the-log/

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#ifdef DEBUG

#else
#define NSLog(format, args...)
#endif

//国际化
#define LocalizedString(key) \
[[InternationalControl bundle] localizedStringForKey:(key) value:nil table:@"Localizable"]

#define STR(key)            NSLocalizedString(key, nil)

//文件路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//iphone尺寸
#define PHOTOWIDTH  (([[UIScreen mainScreen] bounds].size.width > [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)/1.15)
#define PHOTOHEIGHT (([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)/1.15)

//设置颜色更方便
#define color_with_rgba(r,g,b,a) [[UIColor alloc] initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define color_with_rgb(r,g,b) [[UIColor alloc] initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define systemBlueColor color_with_rgb(0, 105, 255)

//ios系统
#define is_ios7 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

//16进制颜色转换
#define COLOR_RGB_16BIT(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgb & 0xFF00) >> 8)) / 255.0 \
blue:((float)((rgb & 0xFF))) / 255.0 \
alpha:1.0]

//简单弹窗显示
#define SHOW_ALERT(title,msg,cancelTitle) [[[UIAlertView alloc] initWithTitle:(title) \
message:(msg) \
delegate:nil \
cancelButtonTitle:(cancelTitle) \
otherButtonTitles:nil] show]

