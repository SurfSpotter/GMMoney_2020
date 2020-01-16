//
//  CellControllerTableViewCell.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 09.01.2020.
//  Copyright © 2020 Алексей Чигарских. All rights reserved.
//

import UIKit

class CellControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var lableCurrencyName: UILabel!
    @IBOutlet weak var labelCourse: UILabel!
    
   
    func initCell (currency: Currency) {

        imageFlag.image = currency.imageFlag
//        imageFlag.layer.cornerRadius = imageFlag.frame.size.width / 2
//        imageFlag.clipsToBounds = true
        lableCurrencyName.text = currency.Name
        initRoundedCourses(currency)
    
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    fileprivate func initRoundedCourses(_ currency: Currency) {
           if currency.valueDouble != nil {
               let roundedAmount = round(Double(currency.valueDouble!) * 100) / 100  //Rounded
               labelCourse.text = String(roundedAmount) + " ₽"  // insert dara and ruble symbol
           } else { labelCourse.text = currency.Value}
       }
       
}
