//
//  MainFileModel.swift
//  iCocos
//
//  Created by iCocos on 2017/11/3.
//  Copyright © 2017年 115.com. All rights reserved.
//
//
//============================================梦工厂============================================//
//                                                                                             //
//                     微信：clpaial10201119(183**7821) / QQ：2211523682                        //
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


import Foundation

enum FileHanleType {
    case None
}

/// 模型数据
class MainFileModel {
    var testName: String = ""
    var testDesc: String = ""
    var testIcon: String = ""
    
    var checked: Bool = false
    var handle: FileHanleType = .None
}

