//
//  WriteViewController.swift
//  OriginalApp
//
//  Created by Yoshinori Shibahara on 2020/10/05.
//

import UIKit
import Realm
import RealmSwift

class WriteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    
    @IBOutlet var writeView: UITextView!
    
    @IBOutlet var saveButton: UIButton!
    
    let date: Date = Date()
    let dateLabelFormatter = DateFormatter()
    let monthLabelFormatter = DateFormatter()
    let yearLabelFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    
    @IBOutlet var deleteAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateLabelFormatter.dateFormat = "dd"
        dateLabel.text = dateLabelFormatter.string(from: date)
        
        monthLabelFormatter.dateFormat = "MMMM"
        monthLabel.text = monthLabelFormatter.string(from: date)
        
        yearLabelFormatter.dateFormat = "yyyy"
        yearLabel.text = yearLabelFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyyMMdd"
        
        writeView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func addModel(_ sender: Any) {
        
        if writeView.text.isEmpty {
            
            let emptyAlert: UIAlertController = UIAlertController(title: "No Text", message: "Please write text to save", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in print("Save Cancelled")}))
            present(emptyAlert, animated: true, completion: nil)
            
        } else {
            
            let instanceModel: Model = Model()
            
            instanceModel.date = dateFormatter.string(from: date)
            instanceModel.text = self.writeView.text
            
            let realmInstance = try! Realm()
            
            try! realmInstance.write {
                realmInstance.add(instanceModel)
            }
            
            print("Saved Entry")
            
        }
        
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            
        }
        
        print("Deleted All Data")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
