//
//  ConverterController.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 06.01.2020.
//  Copyright © 2020 Алексей Чигарских. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {
    
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    
    @IBOutlet weak var labelCoursesForDate: UILabel!
    
    @IBOutlet weak var buttonFrom: UIButton!
    
    @IBOutlet weak var buttonTo: UIButton!
    
    @IBOutlet weak var imageFrom: UIImageView!
    
    @IBOutlet weak var imageTo: UIImageView!
    
    @IBAction func replaceCurrenCurrencies(_ sender: Any) {
        replacingFromToToCurrencies()
        refreshButtons()
    }
    
    
    @IBAction func pushButtonFrom(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .from
        nc.modalPresentationStyle = .fullScreen
        
        
        
        
        
        present(nc, animated: true, completion: nil)
    }
    @IBAction func pushButtonTo(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .to
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var textFrom: UITextField!
    
    @IBOutlet weak var textTo: UITextField!
   
    
    @IBAction func TextFromEditingChanged(_ sender: Any) {
         let amount = Double(textFrom.text!)
        if amount != nil {
            textTo.text = String(roundedTo0x00(amount: amount!))
        }
        if amount == nil {
            textTo.text = ""
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFrom.delegate = self // This is for Showing Done Button (Delegate)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        TextFromEditingChanged(self)
        labelCoursesForDate.text = (Model.shared.currentDate!)
        navigationItem.rightBarButtonItem = nil 
        
    }
    
    
    func refreshButtons() { // Изменяет аббревиатуру валют на вьюхе
        buttonFrom.setTitle(Model.shared.fromCurrency.CharCode!, for: UIControl.State.normal)
        buttonTo.setTitle(Model.shared.toCurrency.CharCode!, for: UIControl.State.normal)
        imageFrom.image = UIImage(named: Model.shared.fromCurrency.CharCode!)
        imageTo.image = UIImage(named: Model.shared.toCurrency.CharCode!)
    }
    
    @IBAction func pushDoneButton(_ sender: Any) {
         textFrom.resignFirstResponder()  // Убрать клавиатуру после нажатия кнопки
        navigationItem.rightBarButtonItem = nil  // кнопку убрать
       
        
        }
    // MARK:- Functions
    fileprivate func replacingFromToToCurrencies() {  //перемещение валют при нажатии кнопки
        let replacedCurrency: Currency = Model.shared.fromCurrency
        var replacedTextField: String? = nil
        Model.shared.fromCurrency = Model.shared.toCurrency
        Model.shared.toCurrency = replacedCurrency
        replacedTextField = textFrom.text
        textFrom.text = textTo.text
        textTo.text = replacedTextField
        // and call refreshButtons()
    }
    
    func roundedTo0x00 (amount: Double) -> Double {// Округление до сотых
        let roundedAmount = round(Double(Model.shared.convert(amount: amount))! * 100) / 100
        return roundedAmount
    }
    
    
    
}

extension ConverterController: UITextFieldDelegate {      // Show Button Done when textFrom is Should Begining
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone // кнопку показать
        return true
    }
    
}
