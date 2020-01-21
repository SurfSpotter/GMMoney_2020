//
//  SelectCurrencyController.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 08.01.2020.
//  Copyright © 2020 Алексей Чигарских. All rights reserved.
//

import UIKit

enum flagCurrencySelected {
    case from
    case to
}

class SelectCurrencyController: UITableViewController {
    
    var flagCurrency: flagCurrencySelected = .from
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Model.shared.currencys.count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellConverterController
        let currentCurrency: Currency = Model.shared.currencys[indexPath.row]
        cell.initCell(currency: currentCurrency)
        
        
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency: Currency = Model.shared.currencys[indexPath.row] // выбрали номер класс в массиве по номеру тыкнутой ячейки
        
        
        if flagCurrency == .from {
            Model.shared.fromCurrency = selectedCurrency
            
        }
        
        if flagCurrency == .to {
            Model.shared.toCurrency = selectedCurrency
        }
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
