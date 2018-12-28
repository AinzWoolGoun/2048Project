//
//  TileView.swift
//  2048Project
//
//  Created by Bookman on 2018/1/23.
//  Copyright © 2018年 Ware. All rights reserved.
//

import UIKit

protocol AppearanceProviderProtocol:class{
    func tileColor(Value:Int)->UIColor
    func numberColor(Value:Int)->UIColor
    
}

class TileView: UIView {

    unowned let delegate:AppearanceProviderProtocol   //weak,unowned修饰的委托变量的协议类型必须是class-only-protocol在协议的继承列表中,通过添加class关键字,限制协议只能适配到类（class）类型
    
    var label:UILabel?
    
    var value:Int = 0{
        didSet{    //监视数值的变化并作出反应,didSet->变化后要做的事，willSet->变化前要做的事
            backgroundColor = delegate.tileColor(Value:value)
            label?.textColor = delegate.numberColor(Value: value)
            label?.text = "\(value)"
        }
    }
    
    init(position:CGPoint,width:CGFloat,value:Int,delegate d:AppearanceProviderProtocol){
        
        delegate = d
        super.init(frame:CGRect(x: position.x, y: position.y, width: width, height: width))
        self.value = value
        label = UILabel(frame:CGRect(x: 0, y: 0, width: width, height: width))
        label?.textAlignment = NSTextAlignment.center
        label?.minimumScaleFactor = 0.5
        label?.font=UIFont(name:"HelveticaNeue-Bold",size:15) ?? UIFont.systemFont(ofSize:15)
        label?.layer.cornerRadius = 6
        backgroundColor = delegate.tileColor(Value: value)
        label?.textColor = delegate.numberColor(Value: value)
        label?.text = "\(self.value)"
        
        self.addSubview(label!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
