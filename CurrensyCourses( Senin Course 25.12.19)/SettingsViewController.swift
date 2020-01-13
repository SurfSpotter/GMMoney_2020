//
//  SettingsViewController.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 30.12.2019.
//  Copyright © 2019 Алексей Чигарских. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func datePickerAction(_ sender: Any) {
    }
    
    
    @IBAction func showCourses(_ sender: Any) {
        Model.shared.loadXmlFile(date: datePicker.date)
        dismiss(animated: true, completion: nil)
        print ("This is DatePicker Date \(datePicker.date)")
    }
    
    @IBAction func pushCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
