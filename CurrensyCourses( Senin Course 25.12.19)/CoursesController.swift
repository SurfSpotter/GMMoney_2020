//
//  CoursesController.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 27.12.2019.
//  Copyright © 2019 Алексей Чигарских. All rights reserved.
//

import UIKit

class CoursesController: UITableViewController {

    @IBAction func pushRefreshButton(_ sender: Any) { Model.shared.loadXmlFile(date: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadingXML"), object: nil, queue: nil) { (Notification) in
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(style: .medium) // устанавливаем крутилку
                activityIndicator.startAnimating()
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
        }
    
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("dataRefreshed"), object: nil, queue: nil) { (Notification) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = Model.shared.currentDate
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.pushRefreshButton(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "ErrorWhenLoadXML"), object: nil, queue: nil) { (notification) in
            let errorName = notification.userInfo?["errorName"]
            if errorName != nil { print (errorName!)}
            
            
            DispatchQueue.main.async {
                
                
                
                self.alertErrorLoadXML()
                
                
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.pushRefreshButton(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
                }
        }
        navigationItem.title = Model.shared.currentDate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Model.shared.loadXmlFile(date: nil)
    }
// MARK: - Alert when Error load XML File
    
    
    fileprivate func alertErrorLoadXML() {
        let alertMessage = UIAlertController(title: "Error", message: "XML file not loaded", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
        }
        alertMessage.addAction(alertAction)
        self.present(alertMessage, animated: true) {
            
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Model.shared.currencys.count
    }
    

  
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellControllerTableViewCell
        let cellForCourses = Model.shared.currencys[indexPath.row]
        cell.initCell(currency: cellForCourses)
        
        
        hideRUBCurrency(cellForCourses, cell, tableView)
        
//        cell.textLabel?.text = cellForCourses.Name
//        cell.detailTextLabel?.text = cellForCourses.Value

        return cell
    }
    
// Mark: Function to hide Rub currency in Main Page
   fileprivate func hideRUBCurrency(_ cellForCourses: Currency, _ cell: CellControllerTableViewCell, _ tableView: UITableView) {
        if cellForCourses.CharCode == "RUB" {
            cell.isHidden = true
            self.tableView.rowHeight = 0.0
        }
        else { tableView.rowHeight = 80.0
            
        }
    }

}
