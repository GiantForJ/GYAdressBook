//
//  GYTConactCell.swift
//  GYAdressBook
//
//  Created by zhuguangyang on 16/9/2.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

let ScreenWD = UIScreen.mainScreen().bounds.width

let ScreenHt = UIScreen.mainScreen().bounds.height



class GYTConactCell: UITableViewCell {
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        creatUI()
        
    }
    
    func creatUI() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumLabel)
        
        nameLabel.frame = CGRect(x: 20, y: 5, width: ScreenWD - 40, height: 25)
        
        phoneNumLabel.frame = CGRect(x: 20, y: 30, width: ScreenWD - 40, height: 25)
        
    }
    
    private lazy var nameLabel: UILabel = {
        
        let nameLabel = UILabel()
        
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = UIFont.systemFontOfSize(15)
        nameLabel.textAlignment = .Left
        
        return nameLabel
        
    }()
    
    private lazy var phoneNumLabel: UILabel = {
        
        let nameLabel = UILabel()
        
        
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = UIFont.systemFontOfSize(15)
        nameLabel.textAlignment = .Left
        return nameLabel
        
    }()
    
    func reloadUI(model: GYPersonModel) {
        
        nameLabel.text = model.name1
        
        phoneNumLabel.text = model.phoneNumber
        
    }
    
    //Xib
    override func awakeFromNib() {
        super.awakeFromNib()
        creatUI()
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("error")
        
    }
    
}
