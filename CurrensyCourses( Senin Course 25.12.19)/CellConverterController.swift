//
//  CellConverterController.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 09.01.2020.
//  Copyright © 2020 Алексей Чигарских. All rights reserved.
//

import UIKit

class CellConverterController: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageFlag: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    func initCell(currency: Currency)
    {
    imageFlag.image = currency.imageFlag
    //imageFlag.layer.cornerRadius = imageFlag.frame.size.width / 2
    //imageFlag.clipsToBounds = true
    nameLabel.text = currency.Name
    //labelCourse.text = currency.Value
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
