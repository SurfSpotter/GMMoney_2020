//
//  SettingsViewController.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 30.12.2019.
//  Copyright © 2019 Алексей Чигарских. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    static let shared = SettingsViewController()
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func datePickerAction(_ sender: Any) {
        datePicker.setMaxandMinDateInDatePicker()
    }
    
    
    @IBAction func showCourses(_ sender: Any) {
        Model.shared.loadXmlFile(date: datePicker.date)
        dismiss(animated: true, completion: nil)
        //print ("This is DatePicker Date \(datePicker.date)")
    }
    
    @IBAction func pushCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}


//MARK: Ограничения по минимальной и максимальной дате для UIDatePicker
extension UIDatePicker {
func setMaxandMinDateInDatePicker() {
    let currentDate: Date = Date()
    var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    var components: DateComponents = DateComponents()
    let maxDate: Date = currentDate
    components.year = -22
    let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
    self.minimumDate = minDate
    self.maximumDate = maxDate
    } }
    
