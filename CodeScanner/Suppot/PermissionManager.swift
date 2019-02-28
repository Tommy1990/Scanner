//
//  PermissionManager.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/27.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class PermissionManager:NSObject{
    static let manager = PermissionManager()
    func getCameraPermission(_ vc:UIViewController,_ backClouser:@escaping ((_ boo:Bool)->())){
        let statue = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if statue == .notDetermined{
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (boo) in
                backClouser(boo)
            }
        }else if statue == .authorized{
            backClouser(true)
        }else{
            let alertController = UIAlertController(title: "Camera Permission",
                                                    message: "Usage of Camera is refused, please enter Setting->Privacy->Camera ,switch on!",
                                                    preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Setting", style: .default) { (alertAction) in
                if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(appSettings as URL)
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            vc.present(alertController, animated: true, completion: nil)
            backClouser(false)
        }
    }
}
