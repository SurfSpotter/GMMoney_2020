//
//  RateManager.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 27.01.2020.
//  Copyright © 2020 Алексей Чигарских. All rights reserved.
//

import UIKit
import StoreKit

@available (iOS 10.3, *)


//MARK:- Оценка приложения


class RateManager {
    class func incrementCount() {
        let count = UserDefaults.standard.integer(forKey: "runCount")
            UserDefaults.standard.set(count + 1, forKey: "runCount")
            UserDefaults.standard.synchronize()
 
        
    }
    class func ShowRateItAppByCount() {
        let count = UserDefaults.standard.integer(forKey: "runCount")
        if count == 2 {
            UserDefaults.standard.set(count + 1, forKey: "runCount")
            DispatchQueue.main.asyncAfter(deadline: .now() + 19) {
                SKStoreReviewController.requestReview()
            }
        }
    }
    class func ShowRateItApp() {
           UserDefaults.standard.set(0 , forKey: "runCount")
           SKStoreReviewController.requestReview()
}
}

