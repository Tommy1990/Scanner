//
//  ScannerHistoryTabCell.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/28.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import UIKit

class ScannerHistoryTabCell: UITableViewCell {
    var model:SerialNumModel?{
        didSet{
            if let model = model{
                let df = DateFormatter()
                df.dateFormat = "yyyy.MM.dd hh:mm:ss"
                let timeZone = NSTimeZone(name: "UTC")
                df.timeZone = timeZone! as TimeZone
                let timeGap =  TimeInterval(NSTimeZone.system.secondsFromGMT()) + (model.timeInterVal)
                timeLab.text = df.string(from: Date(timeIntervalSince1970: timeGap))
                SNLab.text = "iPhone   " + (model.SN)
            }
            
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(timeLab)
        contentView.addSubview(SNLab)
        
        timeLab.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(8)
        }
        SNLab.snp.makeConstraints { (make) in
            make.leading.equalTo(timeLab)
            make.top.equalTo(timeLab.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).offset(-8)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }

    lazy var timeLab:UILabel = {
       let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.blue
        return lab
    }()
    lazy var SNLab:UILabel = {
       let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.darkGray
        lab.numberOfLines = 0
        return lab
    }()
}
