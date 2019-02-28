//
//  ScannnerViewController.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/27.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import UIKit
import AVFoundation
class ScannnerViewController: UIViewController {
    var codeLength = 12
    var showAll = false
    var resClouser:((_ res:String)->())?
    let session = AVCaptureSession()
    var layer:AVCaptureVideoPreviewLayer?
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        PermissionManager.manager.getCameraPermission(self) { (boo) in
            if boo{
                DispatchQueue.main.async {
                    self.setSession()
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func setSession(){
        self.session.sessionPreset = AVCaptureSession.Preset.high
        do{
            let input = try AVCaptureDeviceInput(device: device!)
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
        }catch{
            print(error.localizedDescription)
            return
        }
        self.layer = AVCaptureVideoPreviewLayer(session: self.session)
        self.layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(self.layer!)
        self.layer?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized{
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            if self.session.canAddOutput(output){
                self.session.addOutput(output)
                output.metadataObjectTypes = output.availableMetadataObjectTypes
//                [AVMetadataObject.code128]
                
            }
            
        }
        session.startRunning()
    }
    
    private func getTargetSN(_ list:[AVMetadataObject]) -> String{
        for i in 0 ..< list.count{
            if let temp = list[i] as? AVMetadataMachineReadableCodeObject{
                if let res = temp.stringValue{
                    if res.count == codeLength || showAll{
                        return res
                    }
                }
            }
        }
        return ""
    }

}
extension ScannnerViewController:AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let vibrateID = SystemSoundID(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(vibrateID)
        var res:String = ""
        if metadataObjects.count > 0{
            //MARK:-- get one res then stop discren
            session.stopRunning()
            res = getTargetSN(metadataObjects)
        }
        resClouser?(res)
        navigationController?.popViewController(animated: true)
    }
}
