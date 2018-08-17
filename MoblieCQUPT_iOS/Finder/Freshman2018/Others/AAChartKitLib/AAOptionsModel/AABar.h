//
//  AABar.h
//  AAChartKit
//
//  Created by An An on 17/1/19.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : http://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import <Foundation/Foundation.h>
#import "AAGlobalMacro.h"

@class AADataLabels;

@interface AABar : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AABar, NSNumber *,     pointPadding);
AAPropStatementAndPropSetFuncStatement(strong, AABar, NSNumber *,     groupPadding);
AAPropStatementAndPropSetFuncStatement(strong, AABar, NSNumber *,     borderWidth);
AAPropStatementAndPropSetFuncStatement(assign, AABar, BOOL,           colorByPoint);//对每个不同的点设置颜色(当图表类型为 column 时,设置为 column 对象的属性,当图表类型为 bar 时,应该设置为 bar 对象的属性才有效)
AAPropStatementAndPropSetFuncStatement(strong, AABar, AADataLabels *, dataLabels);
AAPropStatementAndPropSetFuncStatement(strong, AABar, NSNumber *,     borderRadius);

@end
