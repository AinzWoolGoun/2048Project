//
//  GameAction.swift
//  2048Project
//
//  Created by Bookman on 2018/1/29.
//  Copyright © 2018年 Ware. All rights reserved.
//

import Foundation

enum MoveDirection{  //用户的操作
    case UP
    case DOWN
    case LEFT
    case RIGHT
}

enum TileAction{
    case NOACTION(source:Int, value:Int)
    case MOVE(source:Int, value:Int)
    case SINGLECOMBINE(source:Int, value:Int)
    case DOUBLECOMBINE(firstSource:Int, secondSource:Int, value:Int)
 
    func getValue()->Int{
        switch self {
        case let .NOACTION(_,value):return value
        case let .MOVE(_,value):return value
        case let .SINGLECOMBINE(_,value):return value
        case let .DOUBLECOMBINE(_,_,value):return value
        }
    }
    
    func getSource()->Int{
        switch self {
        case let .NOACTION(source,_):return source
        case let .MOVE(source,_):return source
        case let .SINGLECOMBINE(source,_):return source
        case let .DOUBLECOMBINE(source,_,_):return source
        }
    }
}

enum MoveOrder{
    case SINGLEMOVEORDER(source:Int,destination:Int,value:Int,merged:Bool)
    case DOUBLEMOVEORDER(firstSource:Int,secondSource:Int,destination:Int,value:Int)
}




