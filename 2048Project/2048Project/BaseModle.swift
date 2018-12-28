//
//  BaseModle.swift
//  2048Project
//
//  Created by Bookman on 2018/1/23.
//  Copyright © 2018年 Ware. All rights reserved.
//

import Foundation

enum TileEnum{
    case Empty
    case Tile(Int)
}


struct SequenceGamebord<T>{
    var demision :Int
    var tileArray:[T]   //存放实际值的数组
    
    init(demision d:Int, initValue:T){
        self.demision = d
        tileArray = [T](repeating:initValue, count:d*d)
        
    }
    
    subscript(row:Int,col:Int)->T{//subscript就是给结构体定义下标访问方式
        get{
            assert(row >= 0 && row < demision && col >= 0 && col < demision)
            return tileArray[demision*row+col]
        }
        set{
            assert(row >= 0 && row < demision && col >= 0 && col < demision)
            tileArray[demision*row+col] = newValue
        }
        
        
    }
    
    //mutating是结构体在修改自身属性时必须要加的
    mutating func setAll(value:T){
        for i in 0..<demision{
            for j in 0..<demision{
                self[i,j] = value
            }
        }
    }
    
}
