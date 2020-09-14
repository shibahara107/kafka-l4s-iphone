//
//  ViewController.swift
//  CocoaPodsApp
//
//  Created by Yoshinori Shibahara on 2020/09/14.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        HUD.flash(.success, delay: 2.0)
    }


}

