//
//  ViewController.swift
//  ItuDareGame
//
//  Created by Yoshinori Shibahara on 2020/09/03.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var ituLabel: UILabel!
    @IBOutlet var dokodeLabel: UILabel!
    @IBOutlet var daregaLabel: UILabel!
    @IBOutlet var doshitaLabel: UILabel!
    
    let ituArray: [String] = ["1年前", "1週間前", "昨日", "今日", "10年前", "むかしむかし"]
    let dokodeArray: [String] = ["山の上で", "アメリカで", "学校で", "クラスで", "海で", "イギリスで"]
    let daregaArray: [String] = ["僕が", "大統領が", "先生が", "友達が", "家族が", "あの人が"]
    let doshitaArray: [String] = ["叫んだ", "演説した", "怒った", "踊った", "泳いだ", "走った"]
    
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func change() {
        ituLabel.text = ituArray[index]
        dokodeLabel.text = dokodeArray[index]
        daregaLabel.text = daregaArray[index]
        doshitaLabel.text = doshitaArray[index]
        
        index = index + 1
        
        if index > 5 {
            index = 0
        }
    }
    
    @IBAction func reset() {
        ituLabel.text = "---"
        dokodeLabel.text = "---"
        daregaLabel.text = "---"
        doshitaLabel.text = "---"
        
        index = 0
    }
    
    @IBAction func random() {
        let ituIndex = Int.random(in: 0...5)
        let dokodeIndex = Int.random(in: 0...5)
        let daregaIndex = Int.random(in: 0...5)
        let doshitaIndex = Int.random(in: 0...5)
        
        print("いつ: \(ituIndex)")
        print("どこで: \(dokodeIndex)")
        print("だれが: \(daregaIndex)")
        print("どうした: \(doshitaIndex)")
        
        ituLabel.text = ituArray[ituIndex]
        dokodeLabel.text = dokodeArray[dokodeIndex]
        daregaLabel.text = daregaArray[daregaIndex]
        doshitaLabel.text = doshitaArray[doshitaIndex]
    }


}

