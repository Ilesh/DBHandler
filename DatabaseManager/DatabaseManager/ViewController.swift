//
//  ViewController.swift
//  DatabaseManager
//
//  Created by Ilesh Panchal on 21/02/18.
//  Copyright © 2018 Ilesh panchal. All rights reserved.
//

import UIKit

//PASTE HERE FOR TESTING PURPOST NOT
class Log: NSObject {
    var id : String = ""
    var Date: String = ""
    var Time : String = ""
    var User_id: String = ""
    var Gross_weight: String = ""
    var Net_weight: String = ""
    var Tare_weight : String = ""
    var Product_id : String = ""
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func getAPICaller(){
        let url = URL(string: "http://jsonplaceholder.typicode.com/users/1")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    print(json)
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }
    
    func APICallerPOST(){
   
        let strUrl = "do_forgot_password"
        guard let serviceUrl = URL(string: strUrl) else {
            return
        }

        let parameterDictionary = ["email" : "test@gmail.com", "panel" : "app"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "email :test@gmail.com,panel:app"
        request.httpBody = postString.data(using: .utf8)
        
        //request.httpBody = httpBody
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                   let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func data_request()
    {
        let url:URL = URL(string: "http://topsdemo.co.in/qa/alcohol_ordering/v.1.4/driver/do_forgot_password")!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "email:test@gmail.com&panel:app"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString)
            
        })
        
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- BUTTON ACTION METHODS
    @IBAction func btnSaveClick (_ sender:AnyObject){
        let logen = Log()
        logen.Date = "Date"
        logen.Time = "Time"
        logen.User_id = "1"
        logen.Gross_weight = "23.5"
        logen.Net_weight = "20.0"
        logen.Tare_weight = "3.5"
        logen.Product_id = ""
        let success = DBManager.sharedInstance.storeToDatabase(LogEnt: logen)
        if success{
            print("Log has been successfully saved.")
        }
    }
    @IBAction func btnRetrivedClick (_ sender:AnyObject){
        let arrLogs = DBManager.sharedInstance.getAllRecord()
        if arrLogs.count > 0 {
            print("Log has been successfully saved.\(arrLogs)")
        }
    }
    @IBAction func btnDeleteClick (_ sender:AnyObject){
        let success = DBManager.sharedInstance.clearDatabase()
        if success{
            print("Cleared all recored successfully")
        }
    }
    
}

