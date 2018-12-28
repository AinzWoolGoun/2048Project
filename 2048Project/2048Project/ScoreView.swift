//
//  ScoreView.swift
//  2048Project
//
//  Created by Bookman on 2018/1/22.
//  Copyright © 2018年 Ware. All rights reserved.
//

import UIKit

protocol ScoreProtocol{
    func scoreChanged(newScore s:Int)
}

class ScoreView: UIView ,ScoreProtocol{
    

    var label:UILabel?
    var score:Int = 0{
        didSet{
            label?.text = "SCORE:\(score)"   //改变label的text
        }
    }
 
    let defaultFrame = CGRect(x:0,y:0,width:140,height:40)
    
    init(backgroundColor bgColor:UIColor,textColor tColor:UIColor, font:UIFont){
        
        
        super.init(frame:defaultFrame)
        self.backgroundColor = bgColor
        
        label = UILabel(frame:defaultFrame)
        label?.textAlignment = NSTextAlignment.center
        label?.textColor = tColor
        label?.font = font
        label?.layer.cornerRadius = 6
        label?.text = "\(0)"
        self.addSubview(label!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scoreChanged(newScore s: Int) {
        score = s
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
