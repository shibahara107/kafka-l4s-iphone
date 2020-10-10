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
        
        let realmInstance = try! Realm()
        let instanceModel = realmInstance.objects(Model.self)
        
        print("Showing All Saved Entries Below:")
        
        for instanceData in instanceModel {
            
            print(String(instanceData.date!), String(instanceData.text!))
        }
        
        print("End of All Saved Entries")
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        let selectedDate = Calendar(identifier: .gregorian)
        let selectedYear = selectedDate.component(.year, from: date)
        let selectedMonth = selectedDate.component(.month, from: date)
        let selectedDay = selectedDate.component(.day, from: date)
        
        let selectedDateString: String = "\(selectedYear)\(selectedMonth)\(selectedDay)"
        
        let realmInstance = try! Realm()
        let instanceModel = realmInstance.objects(Model.self)
        
        for instanceData in instanceModel {
            
            if instanceData.date == selectedDateString {
                print("Selected Date: \(selectedDateString), Found Entry")
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
