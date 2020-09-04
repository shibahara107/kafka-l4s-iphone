//
//  ViewController.swift
//  StopWatch
//
//  Created by Yoshinori Shibahara on 2020/09/03.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var perfectLabel: UILabel!
    
    var count: Float = 0.0
    var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func start() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        }
        perfectLabel.text = ""
    }
    
    @IBAction func stop() {
        if timer.isValid {
            timer.invalidate()
        }
        self.hantei()
    }
    
    @IBAction func reset() {
        if timer.isValid {
            timer.invalidate()
        }
        count = 0
        label.text = String(format: "%.2f", count)
        perfectLabel.text = ""
    }
    
    @objc func up() {
        count = count + 0.01
        label.text = String(format: "%.2f", count)
    }
    
    @objc func hantei() {
        if 9.50 <= count && count < 9.70 {
            perfectLabel.text = "GOOD"
        } else if 9.70 <= count && count < 9.80 {
            perfectLabel.text = "GREAT"
        } else if 9.80 <= count && count <= 10.20 {
            perfectLabel.text = "PERFECT"
        } else if 10.20 < count && count <= 10.30 {
            perfectLabel.text = "GREAT"
        } else if 10.30 < count && count <= 10.50 {
            perfectLabel.text = "GOOD"
        } else {
            perfectLabel.text = "BAD"
        }
    }
    
    
}

