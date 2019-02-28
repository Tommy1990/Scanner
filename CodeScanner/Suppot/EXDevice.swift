//
//  EXDevice.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/27.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import Foundation
import UIKit
let IPHONE6_6S_7_8 = "iphone6/6s/7/8"
let IPHONE6P_6SP_7P_8P = "iphone6p/6sp/7p/8p"
let IPHONEX_XS = "iphonex/iphonexs"
let IPHONEXMAX = "iphonex_max"
let IPHONEXR = "iphonexR"
let IPHONESE_5_5S = "iphone5/5s/se"
let SMALLPHONE = "iphone4s_or_lower"
extension UIDevice {
    class func getCurrentDeviceModel() -> String{
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting:systemInfo.machine )
        let indentifier = machineMirror.children.reduce("") { (identifier, element) -> String in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch indentifier {
        case "iPhone7,2":                               return "iPhone 6"
            
        case "iPhone7,1":                               return "iPhone 6 Plus"
            
        case "iPhone8,1":                               return "iPhone 6s"
            
        case "iPhone8,2":                               return "iPhone 6s Plus"
            
        case "iPhone9,1":                               return "iPhone 7 (CDMA)"
            
        case "iPhone9,3":                               return "iPhone 7 (GSM)"
            
        case "iPhone9,2":                               return "iPhone 7 Plus (CDMA)"
            
        case "iPhone9,4":                               return "iPhone 7 Plus (GSM)"
            
        case "iPhone10,1":                               return "iphone 8"
            
        default:
            break
        }
        
        return indentifier
        
    }
    
    class func getCurrentPhoneStyle()->String {
        let scale = UIScreen.main.scale
        
        switch scale {
        case 1.0:
            return SMALLPHONE
        case 2.0:
            if fabs(Double(SCREEN_HEIGHT) - Double(667)) < Double.ulpOfOne{
                return IPHONE6_6S_7_8
            }else if fabs(Double(SCREEN_HEIGHT) - Double(568)) < Double.ulpOfOne{
                return IPHONESE_5_5S
            }else if fabs(Double(SCREEN_HEIGHT) - Double(896)) < Double.ulpOfOne{
                return IPHONEXR
            }else{
                return  SMALLPHONE
            }
        case 3.0:
            if fabs(Double(SCREEN_HEIGHT) - Double(736)) < Double.ulpOfOne{
                return IPHONE6P_6SP_7P_8P
            }else if fabs(Double(SCREEN_HEIGHT) - Double(812)) < Double.ulpOfOne{
                return IPHONEX_XS
            }else if fabs(Double(SCREEN_HEIGHT) - Double(896)) < Double.ulpOfOne{
                return IPHONEXMAX
            }else{
                return IPHONE6P_6SP_7P_8P
            }
        default:
            return IPHONE6P_6SP_7P_8P
        }
        
    }
    //MARK:-- 判断机型返回float 类型值
    class func getDeviceNum() -> Float{
        var system = utsname()
        uname(&system)
        let machineMirror = Mirror(reflecting: system.machine)
        let identifier = machineMirror.children.reduce("") { (identifier, element) -> String in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        print(identifier)
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return 3.0
        case "iPhone4,1":
            return 4.0
        case "iPhone5,1","iPhone5,2", "iPhone5,3", "iPhone5,4":
            return 5.0
        case "iPhone6,1", "iPhone6,2":
            return 6.0
        case "iPhone7,2":  return 7.1
        case "iPhone7,1":  return 7.2
        case "iPhone8,1":  return 8.1
        case "iPhone8,2":  return 8.2
        case "iPhone8,4":  return 8.0
        case "iPhone9,1","iPhone9,3":   return 9.1
        case "iPhone9,2","iPhone9,4":  return 9.2
        case "iPhone10,1","iPhone10,4":   return 10.1
        case "iPhone10,2","iPhone10,5":   return 10.2
        case "iPhone10,3","iPhone10,6":   return 10.3
        case "iPhone11,1","iPhone11,2","iPhone11,3","iPhone11,4","iPhone11,5","iPhone11,6","iPhone11,7" : return 11.1
        default:
            return 0.0
        }
        
    }
}
