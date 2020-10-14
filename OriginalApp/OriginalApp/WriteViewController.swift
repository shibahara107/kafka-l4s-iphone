//
//  WriteViewController.swift
//  OriginalApp
//
//  Created by Yoshinori Shibahara on 2020/10/05.
//

import UIKit
import Realm
import RealmSwift

class WriteViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    @IBOutlet var pickerButton: UIButton!
    
    let pickerView = UIPickerView(frame: CGRect(x: 20, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.3 - 100, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height * 0.3))
    
    let pickerViewChoices: [[String]] = [["1 day", "1"], ["3 days", "3"], ["7 days", "7"], ["30 days", "30"], ["180 days", "180"], ["1 year", "365"], ["3 years", "1095"], ["5 years", "1825"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateFormatter.dateFormat = "yyyyMMdd"
        
        writeView.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 45)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolBar.setItems([flexSpace, doneButton], animated: false)
        
        writeView.inputAccessoryView = toolBar
        
        writeView.textColor = UIColor.label
        
        let realm = try! Realm()
        let object = realm.objects(Model.self)
        
        let currentDate = Date()
        
        print("Today is:", currentDate)
        
        for instanceData in object {
            
            let createdDate = dateFormatter.date(from: String(instanceData.date!))
            
            if createdDate == currentDate {
                
                print("Already made an entry today")
                writeView.text = instanceData.text
                
            } else {
                print("No entry made today")
                
            }
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.backgroundColor = UIColor.tertiarySystemFill
        pickerView.layer.cornerRadius = 20
        
        let pickerViewToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 45))
        
        let hidePickerViewButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hidePickerView))
        
        pickerViewToolBar.setItems([flexSpace, hidePickerViewButton], animated: false)
                
        pickerView.addSubview(pickerViewToolBar)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabelFormatter.dateFormat = "dd"
        dateLabel.text = dateLabelFormatter.string(from: date)
        
        monthLabelFormatter.dateFormat = "MMMM"
        monthLabel.text = monthLabelFormatter.string(from: date)
        
        yearLabelFormatter.dateFormat = "yyyy"
        yearLabel.text = yearLabelFormatter.string(from: date)
        
        let realm = try! Realm()
        
        let currentDate: String = dateFormatter.string(from: date)
        
        let filterResult = realm.objects(Model.self).filter("date == '\(currentDate)'").isEmpty
        
        if filterResult == true {
            
            writeView.text = "Keep track."
            writeView.textColor = UIColor.lightGray
            saveButton.setTitle("Save", for: .normal)
            writeView.isEditable = true
            writeView.isSelectable = true
            
        } else {
            
            let instanceModel = realm.objects(Model.self)
            
            for instanceData in instanceModel {
                
                if instanceData.date == currentDate {
                    
                    writeView.text = instanceData.text
                    
                    saveButton.setTitle("Edit", for: .normal)
                    writeView.isEditable = false
                    writeView.isSelectable = false
                    writeView.textColor = UIColor.lightGray
                }
            }
            
        }
        
    }
    
    @IBAction func addModel(_ sender: Any) {
        
        if writeView.isEditable == false {
            
            saveButton.setTitle("Save", for: .normal)
            writeView.isEditable = true
            writeView.isSelectable = true
            writeView.textColor = UIColor.label
            
        } else {
            
            if writeView.text.isEmpty {
                
                let emptyAlert: UIAlertController = UIAlertController(title: "No Text", message: "Please write text to save", preferredStyle: .alert)
                emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in print("Save Cancelled")}))
                present(emptyAlert, animated: true, completion: nil)
                
            } else {
                
                let instanceModel: Model = Model()
                
                instanceModel.date = dateFormatter.string(from: date)
                instanceModel.text = self.writeView.text
                
                let currentDate: String = dateFormatter.string(from: date)
                
                let realm = try! Realm()
                
                let filterResult = realm.objects(Model.self).filter("date == '\(currentDate)'").isEmpty
                let filterObject = realm.objects(Model.self).filter("date == '\(currentDate)'")
                
                if filterResult == false {
                    
                    try! realm.write {
                        realm.delete(filterObject)
                    }
                    
                }
                
                try! realm.write {
                    realm.add(instanceModel)
                }
                
                saveButton.setTitle("Edit", for: .normal)
                writeView.isEditable = false
                writeView.isSelectable = false
                writeView.textColor = UIColor.gray
                
                print("Saved Entry")
                
            }
            
        }
        
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            
        }
        
        print("Deleted All Data")
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if writeView.textColor == UIColor.lightGray {
            writeView.text = ""
            writeView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if writeView.text.isEmpty {
            writeView.text = "Keep track."
            writeView.textColor = UIColor.lightGray
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewChoices.count
    }
    
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewChoices[row][0]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerButton.setTitle("Access in \(pickerViewChoices[row][0])", for: .normal)
    }
    
    @IBAction func showPicker(_ sender: Any) {
        
        UIView.transition(with: self.view, duration: 0.2, options: [.transitionCrossDissolve], animations: { self.view.addSubview(self.pickerView) }, completion: nil)
        
    }
    
    @objc func hidePickerView() {
        print("Yoshinori")
        pickerView.removeFromSuperview()
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
