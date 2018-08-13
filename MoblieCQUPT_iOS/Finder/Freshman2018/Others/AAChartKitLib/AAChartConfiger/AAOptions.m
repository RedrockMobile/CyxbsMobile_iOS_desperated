//
//  AAOptions.m
//  AAChartKit
//
//  Created by An An on 17/1/4.
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

#import "AAOptions.h"
#import "AAGlobalMacro.h"

@implementation AAOptions

AAPropSetFuncImplementation(AAOptions, AAChart       *, chart);
AAPropSetFuncImplementation(AAOptions, AATitle       *, title);
AAPropSetFuncImplementation(AAOptions, AASubtitle    *, subtitle);
AAPropSetFuncImplementation(AAOptions, AAXAxis       *, xAxis);
AAPropSetFuncImplementation(AAOptions, AAYAxis       *, yAxis);
AAPropSetFuncImplementation(AAOptions, AATooltip     *, tooltip);
AAPropSetFuncImplementation(AAOptions, AAPlotOptions *, plotOptions);
AAPropSetFuncImplementation(AAOptions, NSArray       *, series);
AAPropSetFuncImplementation(AAOptions, AALegend      *, legend);
AAPropSetFuncImplementation(AAOptions, NSArray       *, colors);
AAPropSetFuncImplementation(AAOptions, BOOL,            gradientColorEnabled);
AAPropSetFuncImplementation(AAOptions, NSString      *, zoomResetButtonText); //String to display in 'zoom reset button"

@end


#define AAFontSizeFormat(fontSize) [NSString stringWithFormat:@"%@%@", fontSize, @"px"]

@implementation AAOptionsConstructor

+ (AAOptions *)configureChartOptionsWithAAChartModel:(AAChartModel *)aaChartModel {
    
    AAChart *aaChart = AAObject(AAChart)
    .typeSet(aaChartModel.chartType)//绘图类型
    .invertedSet(aaChartModel.inverted)//设置是否反转坐标轴，使X轴垂直，Y轴水平。 如果值为 true，则 x 轴默认是 倒置 的。 如果图表中出现条形图系列，则会自动反转
    .backgroundColorSet(aaChartModel.backgroundColor)//设置图表的背景色(包含透明度的设置)
    .pinchTypeSet(aaChartModel.zoomType)//设置手势缩放方向
    .panningSet(true)//设置手势缩放后是否可平移
    .polarSet(aaChartModel.polar);
    
    AATitle *aaTitle = AAObject(AATitle)
    .textSet(aaChartModel.title)//标题文本内容
    .styleSet(AAObject(AAStyle)
              .colorSet(aaChartModel.titleFontColor)//Title font color
              .fontSizeSet(AAFontSizeFormat(aaChartModel.titleFontSize))//Title font size
              .fontWeightSet(aaChartModel.titleFontWeight)//Title font weight
              );
    
    AASubtitle *aaSubtitle = AAObject(AASubtitle)
    .textSet(aaChartModel.subtitle)//副标题内容
    .alignSet(aaChartModel.subtitleAlign)//图表副标题文本水平对齐方式。可选的值有 “left”，”center“和“right”。 默认是：center.
    .styleSet(AAObject(AAStyle)
              .colorSet(aaChartModel.subtitleFontColor)//Subtitle font color
              .fontSizeSet(AAFontSizeFormat(aaChartModel.subtitleFontSize))//Subtitle font size
              .fontWeightSet(aaChartModel.subtitleFontWeight)//Subtitle font weight
              );
    
    AATooltip *aaTooltip = AAObject(AATooltip)
    .enabledSet(aaChartModel.tooltipEnabled)//启用浮动提示框
    .sharedSet(aaChartModel.tooltipShared)//多组数据共享一个浮动提示框
    .crosshairsSet(true)//启用准星线
    //.pointFormatSet(aaChartModel.tooltipValueString)//Tooltip value point format string
    .valueSuffixSet(aaChartModel.tooltipValueSuffix);//浮动提示框的单位名称后缀
    
    AAPlotOptions *aaPlotOptions = AAObject(AAPlotOptions)
    .seriesSet(AAObject(AASeries)
               //.colorByPointSet(false)//决定了图表是否给每个数据列或每个点分配一个颜色，默认值是 false， 即默认是给每个数据类分配颜色，
               .stackingSet(aaChartModel.stacking)//设置是否百分比堆叠显示图形
               );
    
    if (aaChartModel.animationType != 0) {
        aaPlotOptions.series.animation = (AAObject(AAAnimation)
                                          .easingSet(aaChartModel.animationType)
                                          .durationSet(aaChartModel.animationDuration)
                                          );
    }
    
    [self configureTheStyleOfConnectNodeWithChartModel:aaChartModel plotOptions:aaPlotOptions];
    aaPlotOptions = [self configureTheAAPlotOptionsWithPlotOptions:aaPlotOptions chartModel:aaChartModel];
    //   aaPlotOptions.series.events = @{@"click":@"hahaha"};
    
    AALegend *aaLegend = AAObject(AALegend)
    .enabledSet(aaChartModel.legendEnabled);//是否显示 legend
    
    AAOptions *aaOptions = AAObject(AAOptions)
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .tooltipSet(aaTooltip)
    .plotOptionsSet(aaPlotOptions)
    .legendSet(aaLegend)
    .seriesSet(aaChartModel.series)
    .colorsSet(aaChartModel.colorsTheme)//设置颜色主题
    .gradientColorEnabledSet(aaChartModel.gradientColorEnabled)//设置主题颜色是否为渐变色
    .zoomResetButtonTextSet(aaChartModel.zoomResetButtonText);//设置重置缩放按钮的默认标题
    
    if (   aaChartModel.chartType != AAChartTypePie
        && aaChartModel.chartType != AAChartTypePyramid
        && aaChartModel.chartType != AAChartTypeFunnel) {
        [self configureAxisContentAndStyleWithAAOptions:aaOptions AAChartModel:aaChartModel];
    }
    
    return aaOptions;
}

+ (void)configureAxisContentAndStyleWithAAOptions:(AAOptions *)aaOptions AAChartModel:(AAChartModel *)aaChartModel {
    
    AAXAxis *aaXAxis = AAObject(AAXAxis)
    .labelsSet(AAObject(AALabels)
               .enabledSet(aaChartModel.xAxisLabelsEnabled)//设置 x 轴是否显示文字
               .styleSet(AAObject(AAStyle)
                         .colorSet(aaChartModel.xAxisLabelsFontColor)//xAxis Label font color
                         .fontSizeSet(AAFontSizeFormat(aaChartModel.xAxisLabelsFontSize))//xAxis Label font size
                         .fontWeightSet(aaChartModel.xAxisLabelsFontWeight)//xAxis Label font weight
                         )
               )
    .reversedSet(aaChartModel.xAxisReversed)
    .gridLineWidthSet(aaChartModel.xAxisGridLineWidth)//x轴网格线宽度
    .categoriesSet(aaChartModel.categories)
    .visibleSet(aaChartModel.xAxisVisible)//x轴是否可见
    .tickIntervalSet(aaChartModel.xAxisTickInterval);//x轴坐标点间隔数
    
    if ([aaChartModel.xAxisCrosshairWidth floatValue]>0) {
        aaXAxis.crosshairSet(AAObject(AACrosshair)
                             .widthSet(aaChartModel.xAxisCrosshairWidth)
                             .colorSet(aaChartModel.xAxisCrosshairColor)
                             .dashStyleSet(aaChartModel.xAxisCrosshairDashStyleType)
                             );
    }
    
    AAYAxis *aaYAxis = AAObject(AAYAxis)
    .labelsSet(AAObject(AALabels)
               .enabledSet(aaChartModel.yAxisLabelsEnabled)//设置 y 轴是否显示数字
               .styleSet(AAObject(AAStyle)
                         .colorSet(aaChartModel.yAxisLabelsFontColor)//yAxis Label font color
                         .fontSizeSet(AAFontSizeFormat(aaChartModel.yAxisLabelsFontSize))//yAxis Label font size
                         .fontWeightSet(aaChartModel.yAxisLabelsFontWeight)//yAxis Label font weight
                         )
               .formatSet(@"{value:.,0f}")//让y轴的值完整显示 而不是100000显示为100k
               )
    .minSet(aaChartModel.yAxisMin)//设置 y 轴最小值,最小值等于零就不能显示负值了
    .maxSet(aaChartModel.yAxisMax)//y轴最大值
    .tickPositionsSet(aaChartModel.yAxisTickPositions)//自定义Y轴坐标
    .allowDecimalsSet(aaChartModel.yAxisAllowDecimals)//是否允许显示小数
    .plotLinesSet(aaChartModel.yAxisPlotLines) //标示线设置
    .reversedSet(aaChartModel.yAxisReversed)
    .gridLineWidthSet(aaChartModel.yAxisGridLineWidth)//y轴网格线宽度
    .titleSet(AAObject(AATitle)
              .textSet(aaChartModel.yAxisTitle))//y 轴标题
    .lineWidthSet(aaChartModel.yAxisLineWidth)//设置 y轴轴线的宽度,为0即是隐藏 y轴轴线
    .visibleSet(aaChartModel.yAxisVisible)
    .tickIntervalSet(aaChartModel.yAxisTickInterval);
    
    if ([aaChartModel.yAxisCrosshairWidth floatValue]>0) {
        aaYAxis.crosshairSet(AAObject(AACrosshair)
                             .widthSet(aaChartModel.yAxisCrosshairWidth)
                             .colorSet(aaChartModel.yAxisCrosshairColor)
                             .dashStyleSet(aaChartModel.yAxisCrosshairDashStyleType)
                             );
    }
    
    aaOptions.xAxis = aaXAxis;
    aaOptions.yAxis = aaYAxis;
}

+ (void)configureTheStyleOfConnectNodeWithChartModel:(AAChartModel *)aaChartModel plotOptions:(AAPlotOptions *)aaPlotOptions {
    //数据点标记相关配置，只有线性图(折线图、曲线图、折线区域填充图、曲线区域填充图)才有数据点标记
    if (   aaChartModel.chartType == AAChartTypeArea
        || aaChartModel.chartType == AAChartTypeAreaspline
        || aaChartModel.chartType == AAChartTypeLine
        || aaChartModel.chartType == AAChartTypeSpline) {
        AAMarker *aaMarker = AAObject(AAMarker)
        .radiusSet(aaChartModel.markerRadius)//曲线连接点半径，默认是4
        .symbolSet(aaChartModel.symbol);//曲线点类型："circle", "square", "diamond", "triangle","triangle-down"，默认是"circle"
        if (aaChartModel.symbolStyle == AAChartSymbolStyleTypeInnerBlank) {
            aaMarker.fillColorSet(@"#ffffff")//点的填充色(用来设置折线连接点的填充色)
            .lineWidthSet(@2)//外沿线的宽度(用来设置折线连接点的轮廓描边的宽度)
            .lineColorSet(@"");//外沿线的颜色(用来设置折线连接点的轮廓描边颜色，当值为空字符串时，默认取数据点或数据列的颜色)
        } else if (aaChartModel.symbolStyle == AAChartSymbolStyleTypeBorderBlank) {
            aaMarker.lineWidthSet(@2)
            .lineColorSet(aaChartModel.backgroundColor);
        }
        AASeries *aaSeries = aaPlotOptions.series;
        aaSeries.connectNulls = aaChartModel.connectNulls;
        aaSeries.marker = aaMarker;
    }
}

+ (AAPlotOptions *)configureTheAAPlotOptionsWithPlotOptions:(AAPlotOptions *)aaPlotOptions chartModel:(AAChartModel *)aaChartModel {
    
    AAChartType chartType = aaChartModel.chartType;
    
    AADataLabels *aaDataLabels;
    if (aaChartModel.dataLabelEnabled == true) {
        aaDataLabels = (AAObject(AADataLabels)
                        .enabledSet(aaChartModel.dataLabelEnabled)
                        .styleSet(AAObject(AAStyle)
                                  .colorSet(aaChartModel.dataLabelFontColor)
                                  .fontSizeSet(AAFontSizeFormat(aaChartModel.dataLabelFontSize))
                                  .fontWeightSet(aaChartModel.dataLabelFontWeight)
                                  )
                        );
    }
    
    if (chartType == AAChartTypeColumn) {
        AAColumn *aaColumn = (AAObject(AAColumn)
                              .borderWidthSet(@0)
                              //.groupPaddingSet(@0.05)
                              .borderRadiusSet(aaChartModel.borderRadius)
                              .dataLabelsSet(aaDataLabels));
        if (aaChartModel.polar == YES) {
            aaColumn.pointPaddingSet(@0)
            .groupPaddingSet(@0.005);
        }
        aaPlotOptions.columnSet(aaColumn);
    } else if (chartType == AAChartTypeBar) {
        AABar *aaBar = (AAObject(AABar)
                        .borderWidthSet(@0)
                        //.groupPaddingSet(@0.1)
                        .borderRadiusSet(aaChartModel.borderRadius)
                        .dataLabelsSet(aaDataLabels));
        if (aaChartModel.polar == YES) {
            aaBar.pointPaddingSet(@0)
            .groupPaddingSet(@0.005);
        }
        aaPlotOptions.barSet(aaBar);
    } else if (chartType == AAChartTypeArea) {
        aaPlotOptions.areaSet(AAObject(AAArea)
                              .dataLabelsSet(aaDataLabels));
    } else if (chartType == AAChartTypeAreaspline) {
        aaPlotOptions.areasplineSet(AAObject(AAAreaspline)
                                    .dataLabelsSet(aaDataLabels));
    } else if (chartType == AAChartTypeLine) {
        aaPlotOptions.lineSet(AAObject(AALine)
                              .dataLabelsSet(aaDataLabels));
    } else if (chartType == AAChartTypeSpline) {
        aaPlotOptions.splineSet(AAObject(AASpline)
                                .dataLabelsSet(aaDataLabels));
    } else if (chartType == AAChartTypePie) {
        AAPie *aaPie = (AAObject(AAPie)
                        .allowPointSelectSet(true)
                        .cursorSet(@"pointer")
                        .showInLegendSet(true)
                        );
        if (aaChartModel.dataLabelEnabled == true) {
            aaPie.dataLabelsSet(aaDataLabels
                                .formatSet(@"<b>{point.name}</b>: {point.percentage:.1f} %")
                                );
        } else {
            aaPie.dataLabelsSet(AAObject(AADataLabels)
                                .enabledSet(false)
                                );
        }
        aaPlotOptions.pieSet(aaPie);
    } else if (chartType == AAChartTypeColumnrange) {
        NSMutableDictionary *columnRangeDic = [[NSMutableDictionary alloc]init];
        [columnRangeDic setValue:@0 forKey:@"borderRadius"];//The color of the border surrounding each column or bar
        [columnRangeDic setValue:@0 forKey:@"borderWidth"];//The corner radius of the border surrounding each column or bar. default：0.
        [columnRangeDic setValue:aaDataLabels forKey:@"dataLabels"];
        aaPlotOptions.columnrangeSet(columnRangeDic);
    } else if (chartType == AAChartTypeArearange) {
        NSDictionary *areaRangeDic = [[NSMutableDictionary alloc]init];
        [areaRangeDic setValue:aaDataLabels forKey:@"dataLabels"];
        aaPlotOptions.arearangeSet(areaRangeDic);
    }
    return aaPlotOptions;
}

@end


