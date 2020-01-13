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
        lableCurrencyName.text = currency.Name
        labelCourse.text = currency.Value
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
}
