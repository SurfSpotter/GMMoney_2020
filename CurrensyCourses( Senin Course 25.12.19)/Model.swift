//
//  Model.swift
//  CurrensyCourses( Senin Course 25.12.19)
//
//  Created by Алексей Чигарских on 25.12.2019.
//  Copyright © 2019 Алексей Чигарских. All rights reserved.
//
/*
<NumCode>036</NumCode>
<CharCode>AUD</CharCode>
<Nominal>1</Nominal>
<Name>Австралийский доллар</Name>
<Value>16,0102</Value>  */

import UIKit

class Currency {
    
// Declare Variables:
    
    var NumCode: String?
    var CharCode: String?
    var Nominal: String?
    var nominalDouble: Double?
    var Name: String?
    var Value: String?
    var valueDouble: Double?
    var imageFlag: UIImage? {
        if let CharCode = CharCode {
            return UIImage(named: CharCode)
        }
    return nil
    }
    
    class func rub() -> Currency {
    let rub = Currency()
        rub.CharCode = "RUB"
        rub.Name = "Российский рубль"
        rub.Nominal = "1"
        rub.nominalDouble = 1.0
        rub.Value = "1"
        rub.valueDouble = 1.0
        return rub
    }
}



class Model: NSObject, XMLParserDelegate {
    static let shared = Model()
    var currencys: [Currency] = []
    var currentDate: String?
    var fromCurrency: Currency = Currency.rub()
    var toCurrency: Currency = Currency.rub()
    
    func convert(amount: Double?) -> String {
        if amount == nil {
            return " "
        }
       
        let d = ((fromCurrency.valueDouble! / fromCurrency.nominalDouble!) / (toCurrency.valueDouble! / toCurrency.nominalDouble!)) * amount!
        
        return String(d)
    }
    
    
    
    // MARK: - Path to XML file
    
    var pathForXml: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"  //поиск пути к файлу
        
        if FileManager.default.fileExists(atPath: path) {  // проверяет есть ли такой файл
            //print(path)
            return path
            
        }
        return Bundle.main.path(forResource: "date", ofType: "xml")! // если файла нет, то эта команда возвращает дефолтный файл
        
        
    }
    
    
    // String -> URL
    var urlForXml: URL {
        return URL(fileURLWithPath: pathForXml)
    }
    
    
 
    
//MARK: - Load XML: http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002
    func loadXmlFile(date: Date? ) {
        var strUrl:String = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            strUrl = strUrl + dateFormatter.string(from: date!)
            
            
            
        }
        
        let url = URL(string: strUrl)
        var errorGlobal : String?
        
        let task = URLSession.shared.dataTask(with: url!) { (data, URLResponse, Error) in
            if Error == nil {
               
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
                let urlForSave = URL(fileURLWithPath: path)
                do {
                    try data?.write(to: urlForSave)
                    
                    print("Data download")
                    self.parseXML()
                   
                }
                catch {
                    print ("Error when data Save  \(error.localizedDescription)")
                    errorGlobal = Error?.localizedDescription
                }
                
            }
            else {
                print ("Error when loadXmlFile " + Error!.localizedDescription)
                errorGlobal = Error?.localizedDescription
            }
            if let errorGlobal = errorGlobal {
                NotificationCenter.default.post(name: NSNotification.Name("ErrorWhenLoadXML") , object: self,
                                                userInfo: ["errorName":errorGlobal]) }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startLoadingXML"), object: self) // уведомление о том что спарсилос, рассылается по всему приложению
        
        task.resume()
        
    }

    
    
//MARK: - Parse XMl:
    
    func parseXML() {
        currencys = [Currency.rub()]
        let parser = XMLParser(contentsOf: urlForXml)
        parser?.delegate = self   // delegate needed
        parser?.parse()
        print ("Data refreshed")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self) // уведомление о том что спарсилос, рассылается по всему приложению
        
        for c in currencys {   // если мы обновим курсы валют за конкретную дату то на странице с конвертации будут обновлены данные по валюте за конкретную дату
            if c.CharCode == fromCurrency.CharCode {
                fromCurrency = c
            }
            if c.CharCode == toCurrency.CharCode {
                toCurrency = c
            }
        }
        
    }
// MARK: - XML Parser Delegate
    
   
    
    
    
    var currentCurrency : Currency?
    var currentCharacter:String?
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "ValCurs" {
            if let currentDateString = attributeDict["Date"] {
                
            currentDate = todayDateVsDateFromXML(currentDateString) // Прописываем дату из XML или пишем "курсы валют на сегодня"
                
                
            }
        }
        
        
        
        
        if elementName == "Valute" {
            currentCurrency = Currency()
        }
        
    }
    
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        currentCharacter = string
        
    }
    
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // при закрытии элемента отлавливаем значение currentCharacter и записыавем его в массив уже созданного класса
        
        
        
        if elementName == "NumCode" {
            currentCurrency?.NumCode = currentCharacter
            
        }
        
        if elementName == "CharCode" {
            currentCurrency?.CharCode = currentCharacter
            
        }
        
        if elementName == "Nominal" {
            currentCurrency?.Nominal = currentCharacter
            currentCurrency?.nominalDouble = Double(currentCharacter!.replacingOccurrences(of: ",", with: "."))
            
        }
        
        if elementName == "Name" {
            currentCurrency?.Name = currentCharacter
            
        }
        
        if elementName == "Value" {
            currentCurrency?.Value = currentCharacter
            currentCurrency?.valueDouble = Double(currentCharacter!.replacingOccurrences(of: ",", with: "."))
        }
        
        // when valute is closures - append object of class to main class array
        if elementName == "Valute" {
            currencys.append(currentCurrency!)
        }

    }
    
    
    
    
//MARK:-  эта функция сравнивает сегодняшнюю дату с датой в XML файле и возвращает в случае совпадение строковое значение "курсы валют на сегодня"
    
    func todayDateVsDateFromXML(_ currentDateString: String) -> String {
        
        
        let todaysDate = NSDate()
        let dateFormatterTodayDate = DateFormatter()
        dateFormatterTodayDate.dateFormat = "dd.MM.yyyy"
        let todayDateInString = dateFormatterTodayDate.string(from: todaysDate as Date)
        
        //let dateInXml: Date  = dateFormatterTodayDate.date(from: currentDateString) ?? todaysDate as Date
        
        switch todayDateInString.compare(currentDateString) {
            
        case .orderedAscending:
            return "Курсы валют на сегодня"
        case .orderedSame:
            return "Курсы валют на сегодня"
        case .orderedDescending:
            return "Курсы валют на \(currentDateString)"
        }
        
        
    }
    
}
