//
//  AddViewController.swift
//  todoRealm
//
//  Created by Yoshinori Shibahara on 2020/09/25.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTodo(_ sender: Any) {
        let instanceTodoModel: TodoModel = TodoModel()
        instanceTodoModel.title = self.textField.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        instanceTodoModel.date = "\(formatter.string(from: datePicker.date))"
        
        let RealmInstance = try! Realm()
        
        try! RealmInstance.write {
            RealmInstance.add(instanceTodoModel)
        }
        
        self.navigationController?.popViewController(animated: true)
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
