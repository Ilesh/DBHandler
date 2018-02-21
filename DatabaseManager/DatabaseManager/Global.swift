//
//  Global.swift
//  QWALL
//
//  Created by Tops on 6/13/17.
//  Copyright © 2017 Tops. All rights reserved.
//  Update New branch for M4Dev

import UIKit
class Global {
    //SDK keys & secrets etc.
    struct tagType {
        static let ContactDetail = "ContactDetail"
        static let Activity = "Activity"
        static let Tasks = "Tasks"
        
    }
    
    struct RavasStableCount {
        static let userid = "userid"
        static let StableCount = "StableCount"
        
        
    }
    
    static let menuHeight:Float = 320
    static let nav_Timer:Float = 0.4
    static let DeviceUUID = UIDevice.current.identifierForVendor!.uuidString
    static let PhoneDigitLimit = 15
    static var IsOffline:Bool = false
    struct SDKKeys {
        struct Twilio {
            static let Id = "AC313568df00fba35fcca607c6a9866d84"
            static let Secret = "1c024ca026674daf6e774901f809ca1d"
            static let FromNumber = "+447481344102"
            static let MsgURL = "https://api.twilio.com/2010-04-01/Accounts/" + Global.SDKKeys.Twilio.Id + "/Messages.json"
        }
        struct Adobe {
            static let ClientId = "8dc74beebd0148c2b0cfaf7eaeddcfbd"
            static let Secret = "0b7e45ae-b581-4e27-b7a7-cc123a89f9aa"
        }
    }
    static var lastPhone:String = ""
    static var lastpass:String = ""
    static var lastrepass:String = ""
    
    
    struct QWALLAppColor {
        static let BlueDark = Global().RGB(r: 28, g: 117, b: 188, a: 1)
        static let Green = Global().RGB(r: 141, g: 199, b: 65, a: 1)
        static let BlueLight = #colorLiteral(red: 0.1098039216, green: 0.4588235294, blue: 0.737254902, alpha: 1)
        static let Black = Global().RGB(r: 0, g: 0, b: 0, a: 1)
        static let lightGray = Global().RGB(r: 137, g: 138, b: 141, a: 1)
        static let darlWind = Global().RGB(r: 60, g: 78, b: 93, a: 1)
        static let Clody = Global().RGB(r: 241, g: 246, b: 248, a: 1) //
        static let ECEC = Global().RGB(r: 236, g: 236, b: 236, a: 1)
        static let orange = Global().RGB(r: 255, g: 114, b: 0, a: 1)
        static let cynn = Global().RGB(r: 5, g: 176, b: 158, a: 1)
        static let DarkGray = Global().RGB(r: 100, g: 100, b: 100, a: 1)
        static let White = Global().RGB(r: 255, g: 255, b: 255, a: 1)
    }
    
    struct Platform {
        static let isSimulator: Bool = {
            #if arch(i386) || arch(x86_64)
                return true
            #endif
            return false
        }()
    }
    
    //Device Compatibility
    struct is_Device {
        static let _iPhone = (UIDevice.current.model as String).isEqual("iPhone") ? true : false
        static let _iPad = (UIDevice.current.model as String).isEqual("iPad") ? true : false
        static let _iPod = (UIDevice.current.model as String).isEqual("iPod touch") ? true : false
    }
    //DatabaseKey
    struct DatabaseKey {
         static let  WC_USERID = "userid";
        // Table name
         static let TABLE_RAVAS_LOG = "RavasLog";
        // COLUMN
         static let KEY_LOG_ID = "id";
         static let KEY_LOG_DATE = "Date";
         static let KEY_LOG_TIME = "Time";
         static let KEY_LOG_USER_ID = "User_id";
         static let KEY_LOG_GROSS_WEIGHT = "Gross_weight";
         static let KEY_LOG_NET_WEIGHT = "Net_weight";
         static let KEY_LOG_TARE_WEIGHT = "Tare_weight";
         static let KEY_LOG_PRODUCT_ID = "Product_id";
    
    }
    
    
    // database error and success message.
    struct DBMANAGERMESSAGES {
        static let WDError = "You have no records available."
    }
    struct RAVASCREDENTIAL {
       static let ravasUUID = "7CB65A8B-67D6-47A1-AE6B-F8DC68F9C540"
        static let  CLIENT_CHARACTERISTIC_DESCRIPTOR:String = "00002902-0000-1000-8000-00805f9b34fb"
        
        static let CLIENT_CHARACTERISTIC_SERVICE:String = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
        static let CLIENT_CHARACTERISTIC_WRITE:String = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
        static let CLIENT_CHARACTERISTIC_NOTIFY:String = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
    }
    
    //Display Size Compatibility
    struct is_iPhone {
        static let _X = (UIScreen.main.bounds.size.height == 2436 ) ? true : false
        static let _6p = (UIScreen.main.bounds.size.height >= 736.0 ) ? true : false
        static let _6 = (UIScreen.main.bounds.size.height <= 667.0 && UIScreen.main.bounds.size.height > 568.0) ? true : false
        static let _5 = (UIScreen.main.bounds.size.height <= 568.0 && UIScreen.main.bounds.size.height > 480.0) ? true : false
        static let _4 = (UIScreen.main.bounds.size.height <= 480.0) ? true : false
    }
    
    //IOS Version Compatibility
    struct is_iOS {
        static let _11 = ((Float(UIDevice.current.systemVersion as String))! >= Float(11.0)) ? true : false
        static let _10 = ((Float(UIDevice.current.systemVersion as String))! >= Float(10.0)) ? true : false
        static let _9 = ((Float(UIDevice.current.systemVersion as String))! >= Float(9.0) && (Float(UIDevice.current.systemVersion as String))! < Float(10.0)) ? true : false
        static let _8 = ((Float(UIDevice.current.systemVersion as String))! >= Float(8.0) && (Float(UIDevice.current.systemVersion as String))! < Float(9.0)) ? true : false
    }
    
    // MARK: -  Shared classes
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //static let singleton = Singleton.sharedSingleton
    static let g_Databasename = "SampleDB"
    //static let DBRavas = "Ravas_Transection_DB"
    
    
    // MARK: -  Screen size
    static let screenWidth : CGFloat = (Global.appDelegate.window!.bounds.size.width)
    static let screenHeight : CGFloat = (Global.appDelegate.window!.bounds.size.height)
    
    // MARK: -  Get UIColor from RGB
    public func RGB(r: Float, g: Float, b: Float, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a))
    }
    
    
    
    // MARK: -  Dispatch Delay
    func delay(delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
   // MARK: -  Web service Base URL
    
  
   static let baseURLPath = "http://topsdemo.co.in/webservices/ble_itrack/ws/"  //M_1
    
   // MARK: -  Application Colors
   struct kAppColor {
        static let Blue = Global().RGB(r: 47.0, g: 128.0, b: 209.0, a: 1.0)
        static let Red = Global().RGB(r: 230.0, g: 47.0, b: 46.0, a: 1.0)
        static let grauy = Global().RGB(r: 229.0, g: 228.0, b: 233.0, a: 1.0)
    static let Enablewhite = Global().RGB(r: 255.0, g: 225.0, b: 255.0, a: 1.0)
    static let Disablewhite = Global().RGB(r: 255.0, g: 255.0, b: 255.0, a: 0.5)
    
    static let EnableBlack = Global().RGB(r: 0.0, g: 0.0, b: 0.0, a: 1.0)
    static let DisableBlack = Global().RGB(r: 0.0, g: 0.0, b: 0.0, a: 0.25)
   }

    // MARK: - Application Fonts
    struct kFont {
        static let Muli_Semibold = "Muli-SemiBold"
        static let Muli_Bold = "Muli-Bold"
        static let Muli_Regular = "Muli-Regular"
        static let QwallFont = "QWall_TOPS"
    }
    
    struct AppUtility {
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            //Global.appDelegate.orientationLock = orientation
        }
        
        /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            
            self.lockOrientation(orientation)
            
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
        
    }

    struct kFontSize {
        static let  TextFieldSmallSize_8:CGFloat = 8
        static let  TextFieldSize:CGFloat = 12
        static let  ButtonSize:CGFloat = 15
        static let  LabelSize:CGFloat = 14
    }
    
    struct g_UserDefaultKey {
        static let DeviceToken: String! = "DEVICE_TOKEN"
    }
    
    struct kAddActivity {
        static let  SelectLifeEvents = "Select Life Events"
        
    }

    // MARK: -  User Data
    struct kLoggedInUserKey {
        static let IsLoggedIn: String! = "QWALLUserIsLoggedIn"
        static let User_id: String! = "QWALLUserId"
        //static let FullName: String! = "QWALLUserFullName"
        static let FirstName: String! = "QWALLUserFName"
        static let LastName: String! = "QWALLUserLName"
        static let SolutionNumber: String! = "QWALLSolutionid"
        static let RoleUser: String! = "QWALLrole"
        static let company_access_code:String = "QWALLcompany_access_code"
        static let contact_id:String = "QWALLcontact_id"
        static let contact_pic:String = "QWALLcontact_pic"
        static let expires:String = "QWALLexpires"
        static let is_details_updated:String = "QWALLis_details_updated"
        static let is_superuser:String = "QWALLisis_superuser"
        static let license_master_id:String = "QWALLislicense_master_id"
        static let onboarding_step:String = "QWALLisonboarding_step"
        static let parent_login_id:String = "QWALLisparent_login_id"
        static let profile_contact_id:String = "QWALLisprofile_contact_id"
        static let support_user_level:String = "QWALLissupport_user_level"
        static let user_roles:String = "QWALLisuser_roles"
        static let user_type:String = "QWALLisuser_type"
        
        static let Email: String! = "QWALLUserEmail"
        static let name: String! = "QWALLUserName"
        static let Gender: String! = "QWALLUserGender"
        static let MobileNumber: String! = "QWALLUserMobileNumber"
        static let Phone: String! = "QWALLUserPhone"
        static let CountryCode: String! = "QWALLUserCountryCode"
        static let CountryName: String! = "QWALLUserCountryName"
        static let rememPassword: String! = "QWALLUser"
        static let rememEmailornumber: String! = "QWALLUserUsernameNumberEmail"
        static let DOB: String! = "QWALLUserDOB"
        static let AccessToken: String! = "QWALLUserAccessToken"
        static let FirstTimeLogin: String! = "QWALLUserFirstTimeLogin"
        
        static let is_remembered: String! = "QWALLUserIsPrivat"
        static let is_Privat: String! = "QWALLUserIsPrivat"
        static let is_Varify: String! = "QWALLUserIsverify"
        static let status: String! = "QWALLUserStatus"
        static let followers: String! = "QWALLUserIsfollower"
        static let following: String! = "QWALLUserIsfollowing"
        static let lastSynctime:String = "lastSynctime"
        static let lastSynctimeDelete:String = "lastSynctimeDelete"
        static let lastPageno:String = "lastPageno"
        static let DobDay:String = "DobDayUserLoggedin"
        static let DobMonth:String = "DobMonthUserLoggedin"
        static let DobYear:String = "DobYearUserLoggedin"
        static let refresh_token:String = "PhoneUserLoggedin"
    }
    
    static var isUpdating:Bool = false

    // MARK: -  String Type for Validation
    enum kStringType : Int {
        case AlphaNumeric
        case AlphabetOnly
        case NumberOnly
        case Fullname
        case Username
        case Email
        case PhoneNumber
    }
    
    struct PhoneType {
        static let mobile: String = "mobile"
        static let home: String = "home"
        static let work: String = "work"
        static let fax: String = "fax"
        static let other: String = "other"
        
    }
    
    struct AddressType {
        
        static let home: String = "home"
        static let work: String = "work"
        static let billing: String = "billing"
        static let shipping: String = "shipping"
        static let other: String = "other"
        
    }
    
    // MARK: -  Post Media Type
    struct kGoogleApiKey {
        static let strPlaceAPIKey: String! = "AIzaSyCu-ZQpT7HFNUriHJ5pnAFkb0xuUZLusyY"
        
    }
    struct kGoogleApis {
        static let strContactApi = "https://www.googleapis.com/auth/contacts.readonly"
        
    }
    
    
    struct SocialKeys {
        static let facebook: String = "facebook"
        static let twitter: String  = "twitter"
        static let google: String = "google"
        static let skype: String = "skype"
        static let linkedin: String = "linkedin"
        static let website: String = "website"
    }
    
    struct DatesName {
        static let BirthDay: String = "birthday"
        
    }
    
    // MARK: -  Create Post: Text Theme Colors
    struct kTextThemeColor {
        static let Start_1 = Global().RGB(r: 248, g: 248, b: 141, a: 1).cgColor
        static let End_1 = Global().RGB(r: 248, g: 248, b: 141, a: 1).cgColor
        
        static let Start_2 = Global().RGB(r: 86, g: 229, b: 159, a: 1).cgColor
        static let End_2 = Global().RGB(r: 40, g: 187, b: 230, a: 1).cgColor
        
        static let Start_3 = Global().RGB(r: 74, g: 144, b: 226, a: 1).cgColor
        static let End_3 = Global().RGB(r: 74, g: 144, b: 226, a: 1).cgColor
        
        static let Start_4 = Global().RGB(r: 220, g: 56, b: 246, a: 1).cgColor
        static let End_4 = Global().RGB(r: 97, g: 63, b: 219, a: 1).cgColor
        
        static let Start_5 = Global().RGB(r: 243, g: 83, b: 105, a: 1).cgColor
        static let End_5 = Global().RGB(r: 243,g: 83, b: 105, a: 1).cgColor
        
        static let Start_6 = Global().RGB(r: 252, g: 209, b: 114, a: 1).cgColor
        static let End_6 = Global().RGB(r: 244, g: 89, b: 106, a: 1).cgColor
        
        static let Start_7 = Global().RGB(r: 137, g: 250, b: 147, a: 1).cgColor
        static let End_7 = Global().RGB(r: 137, g: 250, b: 147, a: 1).cgColor
        
        static let Start_8 = Global().RGB(r: 255, g: 150, b: 225, a: 1).cgColor
        static let End_8 = Global().RGB(r: 255, g: 150, b: 225, a: 1).cgColor
    }
}
