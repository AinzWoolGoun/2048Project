//
//  ViewController.swift
//  2048Project
//
//  Created by Bookman on 2018/1/22.
//  Copyright © 2018年 Ware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func setupGame(_ sender: Any) {
        
        let game=NumbertailGameControl(demension:4,threshold:2048)
        self.present(game,animated:true,completion:nil)  //注意这里要调用对
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

