//
//  ViewController.swift
//  todoRealm
//
//  Created by Yoshinori Shibahara on 2020/09/25.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var itemList: Results<TodoModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let realmInstance1 = try! Realm()
        self.itemList = realmInstance1.objects(TodoModel.self)
        
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let item: TodoModel = self.itemList[(indexPath as NSIndexPath).row]

        cell?.textLabel?.text = item.title
        cell?.detailTextLabel?.text = item.date
                        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let item: TodoModel = self.itemList[(indexPath as NSIndexPath).row]
            
            let RealmInstance = try! Realm()

            try! RealmInstance.write {
                RealmInstance.delete(item)
            }
        }
        
        tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
    }


}

