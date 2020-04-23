//
//  ListGridDataSource.swift
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

/// ListGridDataSource数据协议
protocol ListGridDataSource: class {
    
    //控制对应section的瀑布流列数
    func numberOfCols(at section: Int) -> Int
    
    //控制每个cell的尺寸，实际上就是获取宽高比
    func sizeOfItemAtIndexPath(at indexPath : IndexPath) -> CGSize
    
    //控制瀑布流cell的间距
    func spaceOfCells(at section: Int) -> CGFloat
    
    //边距
    func sectionInsets(at section: Int) -> UIEdgeInsets
    
    //每个section的header尺寸
    func sizeOfHeader(at section: Int) -> CGSize
    
    //每个cell的额外高度
    func heightOfAdditionalContent(at indexPath : IndexPath) -> CGFloat
    
}

// MARK: - 拓展数据
extension ListGridDataSource {
    
    func spaceOfCells(at section: Int) -> CGFloat{
        return 0
    }
    
    func sectionInsets(at section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.zero
    }
    
    func sizeOfHeader(at section: Int) -> CGSize{
        return CGSize.zero
    }
    
    func heightOfAdditionalContent(at indexPath : IndexPath) -> CGFloat{
        return 0
    }
    
}




