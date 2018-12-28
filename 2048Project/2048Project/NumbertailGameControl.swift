//
//  NumbertailGameControl.swift
//  2048Project
//
//  Created by Bookman on 2018/1/22.
//  Copyright © 2018年 Ware. All rights reserved.
//

import UIKit

class NumbertailGameControl: UIViewController,GameModleProtocol {

    var demension:Int    //每行每列块数
    var threshold:Int    //最高分数,即出现2048的块游戏通关结束
    let boardWidth:CGFloat=260.0   //游戏区域的长度和高度
    let thinPadding:CGFloat=3.0    //小块之间的间距
    let viewPadding:CGFloat=10.0   //记分板与游戏区之间的间距
    let verticalViewOffset:CGFloat=0.0  //初始化属性
    var gamebord:GameboardView?
    var gameModle:GameModle?
    var scoreView:ScoreView?
    
    
    init(demension d : Int,threshold t : Int){
       
        demension = d < 2 ? 2 : d
        threshold = t < 8 ? 8 : t
        super.init(nibName:nil,bundle:nil)
        view.backgroundColor=UIColor(red:0xE6/255,green:0xE2/255,blue:0xD4/255,alpha:1)
        setupSwipeConttoller()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGame()
      
        gameModle = GameModle(dimension: demension, threshold: threshold, delegate: self)
        gameModle?.insertRandomPositionTile(value: 2)
        gameModle?.insertRandomPositionTile(value: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupGame(){
        let viewWidth = view.bounds.size.width
        let viewHeight = view.bounds.size.height
        //获取游戏区域左上角的那个点的x坐标
        func xposition2Center(view v : UIView)->CGFloat{
            let vWidth = v.bounds.size.width
            return (0.5*(viewWidth-vWidth))
        }
        
        //获取游戏区域左上角的那个点的y坐标
        func yposition2Center(order : Int, views : [UIView])->CGFloat{
            assert(views.count>0)
            let totalViewHeight = CGFloat(views.count-1)*viewPadding+views.map({$0.bounds.size.height}).reduce(verticalViewOffset, {$0+$1})     //$的用法：用来表示闭包中的参数，使用时连in和->,return都可以省略只剩下大括号
            
            let firstY = 0.5*(viewHeight-totalViewHeight)
            var acc:CGFloat = 0
            for i in 0 ..< order{
                acc += viewPadding + views[i].bounds.size.height
            }
            return acc + firstY
            
        }
        //获取具体每一个区块的边长，即：(游戏区块长度-间隙总和)/块数
        let width = (boardWidth - thinPadding*CGFloat(demension+1))/CGFloat(demension)
        
        //初始化一个游戏区块对象
        gamebord = GameboardView(demension: demension,titleWidth:width,titlePadding:thinPadding,backgroundColor:UIColor(red:0x90/255,green:0x8D/255,blue:0x80/255,alpha:1),foregroundColor:UIColor(red:0xF9/255,green:0xF9/255,blue:0xE3/255,alpha:0.5))
        
        
        //初始化一个记分板
        
        scoreView = ScoreView(backgroundColor:UIColor(red : 0xA2/255, green : 0x94/255, blue : 0x5E/255, alpha : 1),textColor: UIColor(red : 0xF3/255, green : 0xF1/255, blue : 0x1A/255, alpha : 0.5),font: UIFont(name: "HelveticaNeue-Bold", size: 16.0) ?? UIFont.systemFont(ofSize:16.0))
        
        
        //let views = [scoreView,gamebord]   //一起计算相对位置
    
        
        var f = gamebord?.frame
        //设置游戏区块在整个面板中的的绝对位置，即左上角第一个点
        f?.origin.x = xposition2Center(view: gamebord!)
        f?.origin.y = yposition2Center(order: 0, views: [scoreView!])
        gamebord?.frame = f!
        //将游戏对象加入当前面板中
        
        view.addSubview(gamebord!)
        
        
        f = scoreView!.frame
        f?.origin.x = xposition2Center(view: scoreView!)
        f?.origin.y = yposition2Center(order: 0, views: [gamebord!])
        scoreView?.frame = f!
        view.addSubview(scoreView!)
        
    }
    
    
    func changeScore(score: Int) {
        scoreView?.scoreChanged(newScore: score)
        //view.addSubview(scoreView!)
    }
    
    func insertTile(pare: (Int, Int), value : Int) {
        gamebord?.insertTile(pos: pare, value: value)
       // view.addSubview(gamebord!)
    }
    
    func moveOneTiles(from: (Int, Int), to: (Int, Int), value: Int) {
        gamebord?.moveOneTiles(from: from, to: to, value: value)
        //view.addSubview(gamebord!)
    }
    
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        gamebord?.moveTwoTiles(from: from, to: to, value: value)
       // view.addSubview(gamebord!)
    }
    
    
 
    //注册监听器，监听当前视图里的手指滑动操作，上下左右分别对应下面的四个方法
    func setupSwipeConttoller() {
        let upSwipe = UISwipeGestureRecognizer(target: self , action: #selector(self.upCommand(r:)))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self , action: #selector(self.downCommand(r:)))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self , action: #selector(self.leftCommand(r:)))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self , action: #selector(self.rightCommand(r:)))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(rightSwipe)
    }
    //向上滑动的方法，调用queenMove，传入MoveDirection.UP
    @objc func upCommand(r : UIGestureRecognizer) {
        let m = gameModle!
        m.queenMove(direction: MoveDirection.UP , completion: { (changed : Bool) -> () in
            if  changed {
                self.followUp()
            }
        })
    }
    //向下滑动的方法，调用queenMove，传入MoveDirection.DOWN
    @objc func downCommand(r : UIGestureRecognizer) {
        let m = gameModle!
        m.queenMove(direction: MoveDirection.DOWN , completion: { (changed : Bool) -> () in
            if  changed {
                self.followUp()
            }
        })
    }
    //向左滑动的方法，调用queenMove，传入MoveDirection.LEFT
    @objc func leftCommand(r : UIGestureRecognizer) {
        let m = gameModle!
        m.queenMove(direction: MoveDirection.LEFT , completion: { (changed : Bool) -> () in
            if  changed {
                self.followUp()
            }
        })
    }
    //向右滑动的方法，调用queenMove，传入MoveDirection.RIGHT
    @objc func rightCommand(r : UIGestureRecognizer) {
        let m = gameModle!
        m.queenMove(direction: MoveDirection.RIGHT , completion: { (changed : Bool) -> () in
            if  changed {
                self.followUp()
            }
        })
    }
    
    
    //移动之后需要判断用户的输赢情况，如果赢了则弹框提示，给一个重玩和取消按钮
    func followUp() {
        assert(gameModle != nil)
        let m = gameModle!
        let (userWon, _) = m.userHasWon()
        if userWon {
            let winAlertView = UIAlertController(title: "結果", message: "你贏了", preferredStyle: UIAlertController.Style.alert)
            let resetAction = UIAlertAction(title: "重置", style: UIAlertAction.Style.default, handler: {(u : UIAlertAction) -> () in
                self.reset()
            })
            winAlertView.addAction(resetAction)
            let cancleAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.default, handler: nil)
            winAlertView.addAction(cancleAction)
            self.present(winAlertView, animated: true, completion: nil)
            return
        }
        
        //如果没有赢则需要插入一个新的数字块
        m.insertRandomPositionTile(value: 2)
        
        //插入数字块后判断是否输了，输了则弹框提示
        if m.userHasLost() {
            NSLog("You lost...")
            let lostAlertView = UIAlertController(title: "結果", message: "你輸了", preferredStyle: UIAlertController.Style.alert)
            let resetAction = UIAlertAction(title: "重置", style: UIAlertAction.Style.default, handler: {(u : UIAlertAction) -> () in
                self.reset()
            })
            lostAlertView.addAction(resetAction)
            let cancleAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.default, handler: nil)
            lostAlertView.addAction(cancleAction)
            self.present(lostAlertView, animated: true, completion: nil)
        }
    }
    
    func reset(){
        assert(gamebord != nil && gameModle != nil)
        let b = gamebord!
        let m = gameModle!
        b.reset()
        m.reset()
        m.insertRandomPositionTile(value: 2)
        m.insertRandomPositionTile(value: 2)
        
    }
    

}
