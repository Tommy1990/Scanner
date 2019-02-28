//
//  ScannerViewController.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/27.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
class MainViewController: UIViewController {

    var scanList:[SerialNumModel] = []{
        didSet{
            resTabView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Scan"
        self.navigationController?.navigationBar.isTranslucent = false
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitle("list", for: .normal)
        let barBtn = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = barBtn
        btn.addTarget(self, action:#selector(listBtnClick(_:)), for: .touchUpInside)
        setupUI()
        scanList = SNManager.tempSNList
        SNManager.tempSNList.removeAll()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(scanBtn)
        view.addSubview(desLab)
        view.addSubview(seperatLine)
        view.addSubview(resTabView)
        view.addSubview(submitBtn)
        scanBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(60)
            make.width.height.equalTo(100)
        }
        
        desLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(scanBtn)
            make.top.equalTo(scanBtn.snp.bottom).offset(36)
        }
        
        seperatLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(10)
        }
        let gap = IS_IPHONE_XSERIOUS ? -IPHONE_X_OFFSET : 0
        resTabView.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(16)
            make.top.equalTo(seperatLine.snp.bottom).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.bottom.equalTo(view).offset(-36 + gap)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(resTabView)
            make.top.equalTo(resTabView.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        
        resTabView.dataSource = self
        resTabView.separatorStyle = .none
        
        resTabView.rowHeight = 45
        
        resTabView.register(UITableViewCell.self, forCellReuseIdentifier: "cell0")
        resTabView.register(ScannerTabCell.self, forCellReuseIdentifier: "cell1")
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillTermianal), name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillTermianal), name: UIApplication.willResignActiveNotification, object: nil)
        scanBtn.addTarget(self, action: #selector(scanBtnClick(_:)), for: .touchUpInside)
        submitBtn.addTarget(self, action: #selector(submitBtnClick(_:)), for: .touchUpInside)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //MARK:-- action
    @objc func scanBtnClick(_ sender:UIButton){
        if scanList.count >= 5{
            MSGProgressHUD.showError("out of 5 SNs,please submit  then scan new", view)
            return
        }
        let vc = ScannnerViewController()
        vc.codeLength = 12
        vc.showAll = true
        vc.resClouser = {[weak self] (sn) in
            print(sn)
            self?.resListInsert(sn)
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func listBtnClick(_ sender:UIButton){
        let vc = DataViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func submitBtnClick(_ sender:UIButton){
        SNManager.SNList.append(contentsOf: scanList)
        scanList.removeAll()
    }
    @objc func applicationWillTermianal(){
        SNManager.tempSNList.removeAll()
        SNManager.tempSNList.append(contentsOf: scanList)
    }
    
    func resListInsert(_ sn:String){
        if sn.count == 0{
            MSGProgressHUD.showError("get none target barcode,please try again", self.view)
            return
        }
        let model = SerialNumModel(sn)
        for i in 0 ..< scanList.count{
            if scanList[i].SN == sn{
                model.scaned = true
                MSGProgressHUD.showError("bar code scaned!", self.view)
                break
            }
        }
        if !model.scaned {
            scanList.append(model)
        }
    
    }
    //MARK:-- set child-views
    lazy var scanBtn:UIButton = {
       let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "scan"), for: .normal)
        return btn
    }()
    lazy var desLab:UILabel = {
        let lab = UILabel()
        lab.text = "Scan Serial Number"
        lab.font.withSize(15)
        lab.sizeToFit()
        return lab
    }()
    lazy var seperatLine: UIView = {
       let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
   lazy var resTabView = UITableView()
    lazy var submitBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("submit", for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        return btn
    }()
}

extension MainViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scanList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? ScannerTabCell{
            cell.index = indexPath.row
            cell.model = self.scanList[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0")
        cell?.textLabel?.text = self.scanList[indexPath.row].SN
        return cell!
    }
}
