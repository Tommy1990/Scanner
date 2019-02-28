//
//  SerialNumModel.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/28.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import UIKit
import Foundation
class SerialNumModel: NSObject,NSCoding {
    var timeInterVal:Double = 0.0
    var SN:String!
    var scaned:Bool = false
    func encode(with aCoder: NSCoder) {
        aCoder.encode(timeInterVal, forKey: "time")
        aCoder.encode(SN, forKey: "SN")
        aCoder.encode(scaned, forKey: "scaned")
    }
    
    required init?(coder aDecoder: NSCoder) {
        timeInterVal = aDecoder.decodeDouble(forKey: "time")
        SN = aDecoder.decodeObject(forKey: "SN") as? String
        scaned = aDecoder.decodeBool(forKey: "scaned")
    }
    
    init(_ sn:String){
        SN = sn
        timeInterVal = Date(timeIntervalSinceNow: 0).timeIntervalSince1970
    }
    
    
}

class SNManager{
    static let TEMP_LIST = "tempsnList"
    static let SN_LIST = "snList"
    class var SNList:[SerialNumModel] {
        get{
             let userAccountPath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/\(SN_LIST).data"
            if (NSKeyedUnarchiver.unarchiveObject(withFile: userAccountPath) != nil) {
                if let res = NSKeyedUnarchiver.unarchiveObject(withFile:userAccountPath)as? [SerialNumModel] {
                    return res
                }
            }
            return []
        }
        set{
            let userAccountPath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/\(SN_LIST).data"
            NSKeyedArchiver.archiveRootObject(newValue, toFile:userAccountPath)
        }
    }
    class var tempSNList:[SerialNumModel] {
        get{
            let userAccountPath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/\(TEMP_LIST).data"
            if (NSKeyedUnarchiver.unarchiveObject(withFile: userAccountPath) != nil) {
                if let res = NSKeyedUnarchiver.unarchiveObject(withFile:userAccountPath)as? [SerialNumModel] {
                    return res
                }
            }
            return []
        }
        set{
            let userAccountPath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/\(TEMP_LIST).data"
            NSKeyedArchiver.archiveRootObject(newValue, toFile:userAccountPath)
        }
    }
}

