//
//  CalendarViewController.swift
//  OriginalApp
//
//  Created by Yoshinori Shibahara on 2020/10/05.
//

import UIKit
import Realm
import RealmSwift
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance  {
    
    let calendarView = FSCalendar(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 500))
    
    let dateFormatter = DateFormatter()
    
    let dateDifferenceLimit: Int = 3
    
    @IBOutlet var entryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        
        calendarView.scrollDirection = .vertical
        
        view.addSubview(calendarView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("CalendarView")
        
        entryTextView.text = ""
        
        calendarView.reloadData()
        
        let realmInstance = try! Realm()
        let instanceModel = realmInstance.objects(Model.self)
        
        print("Showing All Saved Entries Below:")
        
        for instanceData in instanceModel {
            
            print(String(instanceData.date!), String(instanceData.text!))
        }
        
        print("End of All Saved Entries")
                
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        entryTextView.text = ""
        
        let selectedDate = Calendar(identifier: .gregorian)
        let selectedYear = selectedDate.component(.year, from: date)
        let selectedMonth = selectedDate.component(.month, from: date)
        let selectedDay = selectedDate.component(.day, from: date)
        
        let selectedDateString: String = "\(selectedYear)\(selectedMonth)\(selectedDay)"
        
        let realmInstance = try! Realm()
        let instanceModel = realmInstance.objects(Model.self)
        
        let currentDate = Date()
        
        for instanceData in instanceModel {
            
            let createdDate = dateFormatter.date(from: String(instanceData.date!))
            
            let dateDifference = Calendar.current.dateComponents([.day], from: currentDate, to: createdDate!)
                        
            if instanceData.date == selectedDateString {
                print("Selected Date: \(selectedDateString), Found Entry")
                
                if dateDifference.day! >= dateDifferenceLimit {
                    print(" >Found Accessible Entry")
                    
                    entryTextView.text = instanceData.text
                    
                } else {
                    print(" >No Accessible Entry Found")
                    
                    entryTextView.text = "You can access this entry in \(dateDifferenceLimit - dateDifference.day!) days"
                }
                
            } else {
                print("Selected Date: \(selectedDateString), No Entry Found")
            }
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let dateString = self.dateFormatter.string(from: date)
        
        let realmInstance = try! Realm()
        let instanceModel = realmInstance.objects(Model.self)
        
        for instanceData in instanceModel {
            
            if instanceData.date == dateString {
                return 1
            } else {
                return 0
            }
        }
        
        return 0
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
