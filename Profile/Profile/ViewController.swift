//
//  ViewController.swift
//  Profile
//
//  Created by Yoshinori Shibahara on 2020/09/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileCommentLabel: UILabel!
    @IBOutlet var profileLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapButton1() {
        
        profileImageView.image = UIImage(named: "philImage")
        profileLabel.text = "名前"
        profileCommentLabel.text = "iPhoneメンターのフィルだよ"
    }
    
    @IBAction func tapButton2() {
        
        profileImageView.image = UIImage(named: "trackImage")
        profileLabel.text = "スポーツ"
        profileCommentLabel.text = "陸上競技が好きで、立ち幅跳びが得意"
    }
    
    @IBAction func tapButton3() {
        
        profileImageView.image = UIImage(named: "appleImage")
        profileLabel.text = "好きな食べ物"
        profileCommentLabel.text = "リンゴが好きで、いつも持ち歩いている"
    }
    
    @IBAction func tapButton4() {
        
        profileImageView.image = UIImage(named: "flightImage")
        profileLabel.text = "趣味"
        profileCommentLabel.text = "飛行機に乗って、空を散歩すること"
    }




}

