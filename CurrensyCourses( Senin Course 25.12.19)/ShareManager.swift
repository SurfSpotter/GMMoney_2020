//
//  ShareManager.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 24.01.2020.
//  Copyright © 2020 Алексей Чигарских. All rights reserved.
//

import UIKit
import MessageUI

class ShareManager: NSObject {

    
    var mailController = MFMailComposeViewController()
    func sendMail( recepients: [String], subject: String, text: String, vc: UIViewController) {
        //let mailController = MFMailComposeViewController()
        mailController.setToRecipients(recepients)
        mailController.mailComposeDelegate = self
        
        mailController.setSubject(subject)
        mailController.setMessageBody(text, isHTML: false)
        vc.present(mailController, animated: true, completion: nil)
        
    }
    
}

extension ShareManager: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
