//
//  OtherViewController.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 22.01.2020.
//  Copyright © 2020 Алексей Чигарских. All rights reserved.
//

import UIKit
import MessageUI

class OtherViewController: UIViewController {
 static let shared = OtherViewController()
    
    
    
    @IBOutlet weak var writeTodeveloper: UIButton!
    
    @IBAction func switchOffBannerAction(_ sender: Any) {
    }
    
    @IBAction func writeToDeveloperAction(_ sender: Any) {
        showMailComposer()
        
    }
    
    
    @IBAction func developerWebsite(_ sender: Any) {
        if let url = URL(string: "http://surfspotdevelopco.tilda.ws") {
            UIApplication.shared.open(url)
        }
    }
    
   
    @IBAction func rateApp(_ sender: Any) {
        RateManager.ShowRateItApp()
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        if let imageForSharing = UIImage(named: "iconCircleAngles") {
            let urlForSharing : NSURL = NSURL(string: "http://surfspotdevelopco.tilda.ws")!
            let desctriptionForSharing = "Скачай вот это приложение \(urlForSharing) уверен тебе понравится!"
            
            
            let vc = UIActivityViewController(activityItems: [imageForSharing, desctriptionForSharing], applicationActivities: [])
            vc.excludedActivityTypes = [ .airDrop,
                                         .assignToContact,
                                         .openInIBooks,
                                         .markupAsPDF,
                                         .print,
                                         
        ]
            present(vc, animated: true)
        }

        
    }
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = imageOutlet
UIView.animate(withDuration: 0.6,
               animations: {
                item?.transform = CGAffineTransform(scaleX: 0.01, y: 0.95)
},
               completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    item?.transform = CGAffineTransform.identity
                }
})
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    fileprivate func changeStyleOfButtons(Button: UIButton) {
            let button = Button
           button.layer.borderWidth = 1.0
           button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 20.0
           button.clipsToBounds = true
       }
    func animationImage(item: UIImageView) {
        let item = item
        UIView.animate(withDuration: 0.6,
        animations: {
            item.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
                item.transform = CGAffineTransform.identity
            }
        })
    }
    private func animationOfButton(item: UIButton ) {
        let item = item
        UIView.animate(withDuration: 0.6,
                       animations: {
                        item.transform = CGAffineTransform(scaleX: 0.01, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            item.transform = CGAffineTransform.identity
                        }
        })
    }
    
    //MARK: - Send Mail Function
    
    fileprivate func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController.init(title: "Error", message: "Your device is not tuned, for send mail", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
                
            }))
            present(alert, animated: true)
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["surfspotdevelop@gmail.com"])
        composer.setSubject("World Money")
        composer.setMessageBody("Привет! Ваше приложение просто супер!, но я бы добавил...(напишите ваше пожелание)", isHTML: false)
        present(composer, animated: true)
        
    
        
    }
    
    }


extension OtherViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        let alertSendMailOk = UIAlertController.init(title: "Сообщение отправлено!", message: "Благодарим за вас за помощь!", preferredStyle: .alert)
        alertSendMailOk.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
            
        }))
        //present(alertSendMailOk, animated: true)
        
        
        if let _ = error {
            // show Error Alert
            print ("error when sent email!")
            controller.dismiss(animated: true, completion: nil)
            let alertError = UIAlertController.init(title: "Ошибка при отправке", message: "Повторите попытку позже.", preferredStyle: .alert)
                       alertError.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
                           
                       }))
                       present(alertError, animated: true)
        }
        
        switch  result {
        case .cancelled:
            print("cancelled")
            controller.dismiss(animated: true, completion: nil)
        case .failed:
            print("failed")
        case .saved:
            print("saved")
        case .sent:
            print ("sent")
            
           
            
        default:
            controller.dismiss(animated: true, completion: nil)
        }
       controller.dismiss(animated: true, completion: nil)
       
    }
}
