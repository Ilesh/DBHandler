//
//  DBManager.swift
//  RafRef_App
//
//  Created by Ilesh on 3/21/17.
//  Copyright © 2017 Self. All rights reserved.
//

import UIKit
import FMDB
import SpinKit

class DBManager: NSObject {
    static let sharedInstance = DBManager(withDBQue: Global.g_Databasename) //Global const
    typealias DBCallerSuccess = (_ responseData: [String: AnyObject]?, _ success: Bool) -> Void
    typealias DBCallerFailure = (_ message:String) -> Void
    
    var dbPath : NSURL!
    var DatabasePAth:String!
    var database : FMDatabase!
    var databaseQue : FMDatabaseQueue!
    var queryResults : FMResultSet?
    
    init(withDBName: String) {
        //self.copyDatabaseIfNeeded()
        _ = FileManager.default
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        let docsDir = dirPaths[0]
        DatabasePAth = docsDir + "/" + withDBName+".db"
        
      //  DatabasePAth = Bundle.main.path(forResource: "\(withDBName)", ofType: ".db")!
        let db = FMDatabase(path: DatabasePAth)
        //print("DB Open From Path......=== \(DatabasePAth)")
        if !(db.open()) {
            print("Unable to open database, some random error happened.")
        }
        else {
            database = db
        }
        
        
    }
    
    init(withDBQue: String) {
        super.init()
        self.copyDatabaseIfNeeded()
        _ = FileManager.default
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        let docsDir = dirPaths[0]
        DatabasePAth = docsDir + "/" + withDBQue+".db"
        
        //  DatabasePAth = Bundle.main.path(forResource: "\(withDBName)", ofType: ".db")!
        databaseQue = FMDatabaseQueue(path: DatabasePAth)
        //print("DB Open From Path......=== \(DatabasePAth)")
        
    }
    
    //MARK:- COPY DATATBASE FILE FROM BUNDLE
    func copyDatabaseIfNeeded() {
        // Move database file from bundle to documents folder
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(Global.g_Databasename + ".db")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent(Global.g_Databasename + ".db")
            
            do {
                print("document URL Path......=== \(documentsURL!.path)")
                print("Final Database Path......=== \(finalDatabaseURL.path)")
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
    }
    
    func getDatabase(dbName : String) -> Bool {
        _ = FileManager.default
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        let docsDir = dirPaths[0]
        DatabasePAth = docsDir + "/" + dbName+".db"
        //DatabasePAth = Bundle.main.path(forResource: "\(dbName)", ofType: ".db")!
        let db = FMDatabase(path: DatabasePAth)
        if !(db.open()) {
            print("Unable to open database, some random error happened.")
        }
        else {
            database = db
            return true
        }
        return false
    }
    ///Closes the connection to the class database
    func closeDatabase() -> Void {
        database.close()
    }
    
    // MARK: -  Add loader in view
    func addShowLoaderInView(viewObj: UIView, boolShow: Bool, enableInteraction: Bool) -> UIView? {
        let viewSpinnerBg = UIView(frame: CGRect(x: (Global.screenWidth - 54.0) / 2.0, y: (Global.screenHeight - 54.0) / 2.0, width: 54.0, height: 54.0))
        viewSpinnerBg.backgroundColor = Global().RGB(r: 240, g: 240, b: 240, a: 0.4)
        viewSpinnerBg.layer.masksToBounds = true
        viewSpinnerBg.layer.cornerRadius = 5.0
        viewObj.addSubview(viewSpinnerBg)
        
        if boolShow {
            viewSpinnerBg.isHidden = false
        }
        else {
            viewSpinnerBg.isHidden = true
        }
        
        if !enableInteraction {
            viewObj.isUserInteractionEnabled = false
        }
        
        //add spinner in view
        let rtSpinKitspinner: RTSpinKitView = RTSpinKitView(style: RTSpinKitViewStyle.styleFadingCircle , color: UIColor.white)
        rtSpinKitspinner.center = CGPoint(x: (viewSpinnerBg.frame.size.width - 8.0) / 2.0, y: (viewSpinnerBg.frame.size.height - 8.0) / 2.0)
        rtSpinKitspinner.color = Global.kAppColor.Blue
        rtSpinKitspinner.startAnimating()
        viewSpinnerBg.addSubview(rtSpinKitspinner)
        
        return viewSpinnerBg
    }
    
    
    // MARK: -  Hide and remove loader from view
    func hideRemoveLoaderFromView(removableView: UIView, mainView: UIView) {
        removableView.isHidden = true
        removableView.removeFromSuperview()
        mainView.isUserInteractionEnabled = true
    }
    
    
    func createTable(tableName : String, sqlStringList : String) -> Bool {
        if database == nil {
            print("Error: No database created")
            return false
        }
        if database.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS \(tableName) (\(sqlStringList))"
            if !database.executeStatements(sql_stmt) {
                print("Error: \(database.lastErrorMessage())")
                return false
            }
            else {
                print("CreateTable SQL Statement succeeded")
                return true
            }
            database.close()
        }
        else {
            print("Error: \(database.lastErrorMessage())")
            return false
        }
    }
    
    func closeDB() -> Bool {
        if database == nil {
            print("Error: No database created")
            return false
        }
        if database.close() {
            return true
        }
        return false
    }
    
    func makeCSV(with: [Log], name: String)
    {
        let fileName = "\(name).csv"
        
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        var patha = dirPaths[0]
        let path = "\(patha)/\(fileName)"
        
        
        //let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        print(path)
        var csvText = "DATE,TIME,USERID,GROSS_WEIGHT,NET_WEIGHT,TARE_WEIGHT,PRODUCT_ID\n"
        for task in with {
            let newLine = "\(task.Date),\(task.Time),\(task.User_id),\(task.Gross_weight),\(task.Net_weight),\(task.Tare_weight),\(task.Product_id)\n"
            csvText.append(newLine)
        }
        do {
            try csvText.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            //try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
    
    func getAllRecord() -> [Log]  {
        guard self.databaseQue != nil else {
            print("Unable to create FMDatabaseQueue")
            return []
        }
        var arr:[Log] = []
        databaseQue.inTransaction { db, rollback in
            
                do {
                    let querySQL = "SELECT * FROM \(Global.DatabaseKey.TABLE_RAVAS_LOG) desc"
                    if let results = db.executeQuery(querySQL, withArgumentsIn: [])
                    {
                        while (results.next()) {
                            let log = Log()
                            log.Date = results.string(forColumn: Global.DatabaseKey.KEY_LOG_DATE) ?? ""
                            log.Time = results.string(forColumn: Global.DatabaseKey.KEY_LOG_TIME) ?? ""
                            log.User_id = results.string(forColumn: Global.DatabaseKey.KEY_LOG_USER_ID) ?? ""
                            log.Gross_weight = results.string(forColumn: Global.DatabaseKey.KEY_LOG_GROSS_WEIGHT) ?? ""
                            log.Net_weight = results.string(forColumn: Global.DatabaseKey.KEY_LOG_NET_WEIGHT) ?? ""
                            log.Tare_weight = results.string(forColumn: Global.DatabaseKey.KEY_LOG_TARE_WEIGHT) ?? ""
                            log.Product_id = results.string(forColumn: Global.DatabaseKey.KEY_LOG_PRODUCT_ID) ?? ""
                            arr.append(log)
                        }
                    }
                } catch {
                    rollback.pointee = true
                }
            }
        return arr
    }
    
    func exportCSVFile(strname: String) -> Bool
     {
        let all = self.getAllRecord()
        if all.count > 0{
            self.makeCSV(with: all, name: strname)
            return true
        }
        return false
        
    }

    func storeToDatabase(LogEnt: Log) -> Bool {
        var success:Bool = true
        let queryString = [LogEnt.Date, LogEnt.Time, LogEnt.User_id, LogEnt.Gross_weight, LogEnt.Net_weight, LogEnt.Tare_weight, LogEnt.Product_id]
        guard self.databaseQue != nil else {
            print("Unable to create FMDatabaseQueue")
            return false
        }
        databaseQue.inTransaction { db, rollback in
            do {
                success = try db.executeUpdate("INSERT INTO \(Global.DatabaseKey.TABLE_RAVAS_LOG)(\(Global.DatabaseKey.KEY_LOG_DATE),\(Global.DatabaseKey.KEY_LOG_TIME),\(Global.DatabaseKey.KEY_LOG_USER_ID),\(Global.DatabaseKey.KEY_LOG_GROSS_WEIGHT),\(Global.DatabaseKey.KEY_LOG_NET_WEIGHT),\(Global.DatabaseKey.KEY_LOG_TARE_WEIGHT),\(Global.DatabaseKey.KEY_LOG_PRODUCT_ID)) VALUES (?,?,?,?,?,?,?)", withArgumentsIn: queryString)
                
            } catch {
                rollback.pointee = true
            }
        }
        return success
    }
    
    func clearDatabase() -> Bool
    {
        var success:Bool = true
        
        guard self.databaseQue != nil else {
            print("Unable to create FMDatabaseQueue")
            return false
        }
        databaseQue.inTransaction { db, rollback in
            do {
                success = try db.executeUpdate("DELETE FROM \(Global.DatabaseKey.TABLE_RAVAS_LOG)", withArgumentsIn: [])
                
            } catch {
                rollback.pointee = true
            }
        }
        return success
    }
    
    func queryDatabaseforRecord(queryString : String) -> Bool {
        
        var success = false
        if database == nil {
            print("Error: No database created")
            return false
        }
        if database.open() {
            let querySQL = "\(queryString)"
            if let results = database.executeQuery(querySQL, withArgumentsIn: []) {
                queryResults = nil
                while (results.next()) {
                    queryResults = results
                    //self.arrObjects[key] = value as AnyObject?
                    success = true
                }
                results.close()
                database.close()
                return success
            }
            database.close()
        }
        else {
            return success
        }
        return success

    }
}
