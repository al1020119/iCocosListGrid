//
//  FlowUtils.swift
//  iCocosFlowe
//
//  Created by iCocos on 2017/11/1.
//  Copyright © 2017年 iCocos. All rights reserved.
//
//
//============================================梦工厂============================================//
//                                                                                             //
//          github博文（如果你对iOS常用技术，基础，底层感兴趣请猛戳这里）：http://al1020119.github.io/   //
//                                                                                             //
//                           github：https://github.com/al1020119                              //
//                                                                                             //
//============================================梦工厂============================================//
//                                                                                             //
//                                                                                             //
//                                          博客地址：                                           //
//                                  https://icocos.github.io/                                  //
//                                  http://al1020119.github.io/                                //
//                                                                                             //
//                                                                                             //
//============================================梦工厂============================================//
//
//


import UIKit

//用来储存某一item的的纵坐标
typealias ColY = (index: Int,colY: CGFloat)

//存储某一列的所有item的位置信息
struct ColPosition{
    
    var colYs: [ColY]
    
    //每个section的高度：返回最大值
    var maxY: CGFloat{
        
        if let max = colYs.max(by: {$0.colY<$1.colY}){
            return max.colY
        }
        return 0
        
    }
    
}


