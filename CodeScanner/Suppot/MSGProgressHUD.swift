//
//  MSGShowManager.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/28.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import UIKit
import MBProgressHUD
import SVProgressHUD
private let loadingStr: String = "正在加载"
private let duration: TimeInterval = 1

enum MSGShowType {
    case loading
    case error
    case success
}

class MSGProgressHUD {
    var hud: MBProgressHUD!
    
    class func defaultShow(_ view: UIView) {
        MSGProgressHUD.show(loadingStr, view)
    }
    class func show(_ withStatus: String, _ view: UIView) {
        MSGProgressHUD.addProgressView(loadingStr, view, .loading)
    }
    //错误
    class func showError(_ status: String!, _ view: UIView) {
        MSGProgressHUD.removeProgfressView(view)
        MSGProgressHUD.showError(status)
    }
    class func showError(_ status: String!) {
        let window = UIApplication.shared.keyWindow!
        MSGProgressHUD.addProgressView(status, window, .error)
    }
    //成功
    class func showSuccess(_ status: String!, _ view: UIView) {
        MSGProgressHUD.removeProgfressView(view)
        MSGProgressHUD.showSuccess(status)
    }
    class func showSuccess(_ status: String!) {
        let window = UIApplication.shared.keyWindow!
        MSGProgressHUD.addProgressView(status, window, .success)
    }
    //消失
    class func dismiss(_ view: UIView) {
        MSGProgressHUD.removeProgfressView(view)
    }
    fileprivate class func addProgressView(_ withStatus: String, _ view: UIView, _ type: MSGShowType) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        switch type {
        case .loading:
            hud.mode = .indeterminate
            hud.frame.origin = CGPoint(x: 100, y: 0)
        case .error:
            hud.mode = .customView
            hud.customView = UIImageView.init(image: UIImage.init(named: "loading_failure"))
            hud.hide(animated: true, afterDelay: duration)
        case .success:
            hud.mode = .customView
            hud.customView = UIImageView.init(image: UIImage.init(named: "loading_success"))
            hud.hide(animated: true, afterDelay: duration)
        }
        hud.label.text = withStatus
        hud.label.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.bezelView.color = UIColor.black
        hud.contentColor = UIColor.white
        hud.removeFromSuperViewOnHide = true
    }
    fileprivate class func removeProgfressView(_ view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

