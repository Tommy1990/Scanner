//
//  DataViewController.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/27.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    var list:[SerialNumModel] = SNManager.SNList
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "list of scaned SNs"
        navigationController?.navigationBar.isTranslucent = false
        setupUI()
    }
    private func setupUI(){
        view.addSubview(tabView)
        
        tabView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(view)
        }
        
        tabView.dataSource = self
        tabView.separatorStyle = .none
        tabView.estimatedRowHeight = 55
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "cell0")
        tabView.register(ScannerHistoryTabCell.self, forCellReuseIdentifier: "cell1")
    }

    
    lazy var tabView = UITableView()
}
extension DataViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? ScannerHistoryTabCell {
            cell.model = list[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0")
        return cell!
    }
    
    
}
