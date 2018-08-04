//
//  ViewController.swift
//  ObserverSetSimpleDemo
//
//  Created by Enjoy on 2018/8/4.
//  Copyright © 2018 enjoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let observerSet1 = ObserverSet<Int>()
        
        observerSet1.add { print($0)}
        
        observerSet1.notify(10)
        
        let observerSet2 = ObserverSet<(String, Int)>()
        
        observerSet2.add { print($0, $1)}
        observerSet2.notify(("hello", 12))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

