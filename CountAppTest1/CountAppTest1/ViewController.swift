//
//  ViewController.swift
//  CountAppTest1
//
//  Created by Yoshinori Shibahara on 2020/09/14.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var number: Int = 0
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label.text = String(number)
    }
    
    @IBAction func plus() {
        number = number + 1
        label.text = String(number)
    }
    
    @IBAction func minus() {
        number = number - 1
        label.text = String(number)
    }
    
    @IBAction func clear() {
        number = number * 0
        label.text = String(number)
    }


}

