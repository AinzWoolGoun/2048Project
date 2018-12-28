//
//  GameboardView.swift
//  2048Project
//
//  Created by Bookman on 2018/1/22.
//  Copyright © 2018年 Ware. All rights reserved.
//

import UIKit

class GameboardView: UIView,AppearanceProviderProtocol {

    
    var demension:Int      //每行列区块数
    var tileWidth:CGFloat   //每个小块的宽度
    var tilePadding:CGFloat  //每个小块之间的距离
    
    
    var tiles = Dictionary<NSIndexPath,TileView>()
    
    
    init(demension d : Int, titleWidth width : CGFloat, titlePadding padding : CGFloat, backgroundColor : UIColor, foregroundColor : UIColor)
    {
        demension = d
        tileWidth = width
        tilePadding = padding
        let totalWidth = tilePadding + CGFloat(demension)*(tilePadding+tileWidth)
        super.init(frame:CGRect(x:totalWidth,y:totalWidth,width:totalWidth,height:totalWidth))
        self.backgroundColor = backgroundColor
        self.setColor(backgroundColor: backgroundColor, foregroundColor: UIColor(red:0xE6/255,green:0xE2/255,blue:0xD4/255,alpha:1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setColor(backgroundColor bgcolor:UIColor, foregroundColor forecolor:UIColor){
        
        self.backgroundColor = bgcolor
        
        var xCursor = tilePadding
        var yCursor:CGFloat
        for _ in 0 ..< demension{
            yCursor = tilePadding
            for _ in 0 ..< demension{
                let tileFrame = UIView(frame:CGRect(x:xCursor,y:yCursor,width:tileWidth,height:tileWidth))
                tileFrame.backgroundColor = forecolor
                tileFrame.layer.cornerRadius = 8
                addSubview(tileFrame)
                yCursor += tilePadding + tileWidth
            }
            xCursor += tilePadding + tileWidth
        }
        
        
    }
    
    func reset(){
        for (_,tile) in tiles{
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepingCapacity: true)
    }
    
    
    
    func tileColor(Value: Int) -> UIColor {
        if Value < 10{
            return UIColor.red
        }
        else{
            return UIColor.blue
        }
    }
    
    func numberColor(Value: Int) -> UIColor {
        if Value < 10{
            return UIColor.black
        }
        else{
            return UIColor.orange
        }
    }
    
    
    func positionIsValied(position:(Int,Int))->Bool{
        let (x,y) = position
        return x >= 0 && x < demension && y >= 0 && y < demension
    }
    
    
    
    func insertTile(pos:(Int,Int),value:Int){
        assert(positionIsValied(position: pos))
        
        let (row,col) = pos
        let x = tilePadding + CGFloat(row)*(tilePadding+tileWidth)
        let y = tilePadding + CGFloat(col)*(tilePadding+tileWidth)
        
        let tileView = TileView(position: CGPoint(x:x,y:y), width: tileWidth, value: value, delegate: self)
        
        addSubview(tileView)
        bringSubviewToFront(tileView)
        
        tiles[NSIndexPath(row:row,section:col)] = tileView
        
        
    }
    
    
    
    func moveOneTiles(from : (Int , Int)  , to : (Int , Int) , value : Int) {
        let (fx , fy) = from
        let (tx , ty) = to
        let fromKey = NSIndexPath(row: fx , section: fy)
        let toKey = NSIndexPath(row: tx, section: ty)
        //取出from位置和to位置的数字块
        guard let tile = tiles[fromKey] else{
            assert(false, "not exists tile")
        }
        let endTile = tiles[toKey]
        //将from位置的数字块的位置定到to位置
        var changeFrame = tile.frame
        changeFrame.origin.x = tilePadding + CGFloat(tx)*(tilePadding + tileWidth)
        changeFrame.origin.y = tilePadding + CGFloat(ty)*(tilePadding + tileWidth)
        
        tiles.removeValue(forKey: fromKey)
        tiles[toKey] = tile
        
        // 给新位置的数字块赋值
        tile.frame = changeFrame
        tile.value = value
        endTile?.removeFromSuperview()
    
        
    }
    
    //将from里两个位置的数字块移动到to位置，并赋予新的值，原理同上
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        assert(positionIsValied(position: from.0) && positionIsValied(position: from.1) && positionIsValied(position: to))
        let (fromRowA, fromColA) = from.0
        let (fromRowB, fromColB) = from.1
        let (toRow, toCol) = to
        let fromKeyA = NSIndexPath(row: fromRowA, section: fromColA)
        let fromKeyB = NSIndexPath(row: fromRowB, section: fromColB)
        let toKey = NSIndexPath(row: toRow, section: toCol)
        
        guard let tileA = tiles[fromKeyA] else {
            assert(false, "placeholder error")
        }
        guard let tileB = tiles[fromKeyB] else {
            assert(false, "placeholder error")
        }
        
        var finalFrame = tileA.frame
        finalFrame.origin.x = tilePadding + CGFloat(toRow)*(tileWidth + tilePadding)
        finalFrame.origin.y = tilePadding + CGFloat(toCol)*(tileWidth + tilePadding)
        
        let oldTile = tiles[toKey]
        oldTile?.removeFromSuperview()
        tiles.removeValue(forKey: fromKeyA)
        tiles.removeValue(forKey: fromKeyB)
        tiles[toKey] = tileA
        
        tileA.frame = finalFrame
        tileB.frame = finalFrame
        tileA.value = value
        tileB.removeFromSuperview()
        
        
    }

    
}
