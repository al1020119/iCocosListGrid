//
//  MainFileCell.swift
//  iCocos
//
//  Created by iCocos on 2017/11/3.
//  Copyright © 2017年 115.com. All rights reserved.
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

/// Cell；列表数据
class MainFileCell: UICollectionViewCell {
    
    var title = UILabel()       // 文件名
    var desc = UILabel()        // 文件描述
    var image = UIImageView()   // 文件图标
    var button = UIButton()     // 选择按钮
    var bottomLine = UIView()   //底部线条
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /// Cell初始化
        
        self.button.setImage(UIImage(named: "company_no_selected"), for: .normal)
        self.button.setImage(UIImage(named: "company_selected"), for: .selected)
        
        title.font = UIFont.systemFont(ofSize: 14)
        desc.font = UIFont.systemFont(ofSize: 12)
        
        desc.textColor = UIColor.gray
        bottomLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        button.isUserInteractionEnabled = false
        
        contentView.addSubview(title)
        contentView.addSubview(desc)
        contentView.addSubview(image)
        contentView.addSubview(button)
        contentView.addSubview(bottomLine)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /// 更新列表cell数据
    ///
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - listGridModel: 模型数据
    ///   - listGridType: 列表类型
    ///   - listGridSelected: 选择状态
    func updateCell(collectionView: UICollectionView, listGridModel: MainFileModel,listGridType: ListGridType, listGridSelected: ListGridSelected) {
        
        // 模型数据赋值与展示
        self.title.text = listGridModel.testName
        self.desc.text = listGridModel.testDesc
        self.image.image = UIImage(named:listGridModel.testIcon)
        
        // 根据列表类型和选中状态控制界面与显示效果
        button.isHidden = !(listGridSelected == .Selected)
        bottomLine.isHidden = listGridType == .Grid ? true : false
        title.textAlignment = listGridType == .Grid ? .center : .left
        desc.textAlignment = listGridType == .Grid ? .center : .left
        
        // 根据列表类型布局子控件
        if listGridType == .Grid {
            title.frame = CGRect(x: 10, y:self.frame.size.height - 45, width: self.frame.size.width - 20, height: 18)
            desc.frame = CGRect(x: 10, y:self.frame.size.height - 20, width: self.frame.size.width - 20, height: 14)
            image.frame = CGRect(x: (self.frame.size.width - 40) / 2, y: 20, width: 40, height: 40)
            button.frame = CGRect(x: image.frame.maxX - 10,y: 10, width: 20, height: 20)
        } else {
            // 由于是列表模式，最左侧是选择按钮，因此需要根据是否是选择模式，来控制左右选择按钮的位置和显示隐藏，并控制右边所有控件的位置（X）
            self.title.frame = CGRect(x: listGridSelected == .Selected ? 90 : 60, y: 8, width:self.frame.size.width - 80, height: 18)
            self.desc.frame = CGRect(x: listGridSelected == .Selected ? 90 : 60, y: 33, width:self.frame.size.width - 80, height: 12)
            self.image.frame = CGRect(x: listGridSelected == .Selected ? 40 : 10, y: 10, width: 40, height: 40)
            self.bottomLine.frame = CGRect(x: listGridSelected == .Selected ? 40 : 10, y: self.frame.size.height - 0.5, width: self.frame.size.width - ((listGridSelected == .Selected) ? 40 : 10), height: 0.5)
            self.button.frame = CGRect(x: listGridSelected == .Selected ? 10 : -20,y: 20, width: 20, height: 20)
        }
        
    }
    
    /// 选中按钮
    ///
    /// - Parameter checked: 选中状态
    func setSelectedItem(checked: Bool) {
        button.isSelected = checked
        self.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


