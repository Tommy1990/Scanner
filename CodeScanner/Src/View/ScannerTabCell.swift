//
//  ScannerTabCell.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/28.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import UIKit

class ScannerTabCell: UITableViewCell {
    var model:SerialNumModel?{
        didSet{
            snLab.text = "iPhone     " +  (model?.SN)!
        }
    }
    var index:Int = 0{
        didSet{
            indexLab.text = String(index + 1)
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
       contentView.addSubview(indexLab)
        contentView.addSubview(snLab)
        
        indexLab.snp.makeConstraints { (make) in
            make.leading.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-8)
            make.width.equalTo(50)
        }
        snLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(indexLab)
            make.leading.equalTo(indexLab.snp.trailing).offset(16)
        }
    }
    lazy var indexLab:UILabel = {
       let lab = UILabel()
        lab.backgroundColor = UIColor.purple
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.textAlignment = .center
        return lab
    }()
    
    lazy var snLab:UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.darkGray
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
}
