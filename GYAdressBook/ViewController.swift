//
//  ViewController.swift
//  GYAdressBook
//
//  Created by zhuguangyang on 16/8/30.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class GYModel: NSObject {
    var name: String?
    
}


enum StringNilError: ErrorType {
    case Nil
    case Unvalid
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var phoneNumLb: UILabel!
    
    var phoneNum:[String] = []
    var phoneAdress:[String] = []
    var phoneNumLbValue:String = ""
    var tablView: UITableView?
    var dataArr:NSMutableArray? {
        
        didSet{
            
            tablView?.reloadData()
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatUI()
        
        initData()
        
        
        
    }
    
    private func initData() {
        
        let arr:NSArray = ["猪猪","ll","宝宝"]
        
        let modelArr:NSMutableArray = NSMutableArray()
        
        for i in 0...2 {
            let model = GYModel()
            model.name = arr[i] as? String
            modelArr.addObject(model)
        }
        
        dataArr = NSMutableArray()
        dataArr =  sortObjectAccordingToInitArr(modelArr)
    }
    
    private func creatUI() {
        tablView = UITableView(frame: CGRect(x: 0, y: 400, width: self.view.frame.size.width, height: 400))
        
        tablView?.dataSource = self
        tablView?.delegate = self
        
        tablView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellPig")
        view.addSubview(tablView!)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let picker = ABPeoplePickerNavigationController()
        
        picker.peoplePickerDelegate = self
        self.presentViewController(picker, animated: true) { 
            
            print("666")
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func sortObjectAccordingToInitArr(arr: NSArray) -> NSMutableArray {
        
        // 进行本地化按首字母分组排序
        let collation = UILocalizedIndexedCollation.currentCollation()
        
        //得出索引数量 27 (26个英文字母+#)
        let sectionTitlesCount = collation.sectionTitles.count
        
        let newSectionsArray = NSMutableArray(capacity: sectionTitlesCount)
        
        //添加27个空数组
        for _ in 0..<sectionTitlesCount {
            
            let array = NSMutableArray()
            
            newSectionsArray.addObject(array)
            
            
        }
        
        /**
         *  将每个名字分到某个section下
         */
        for str:GYModel in arr as! [GYModel] {
            
            /// 首字母的位置 按照模型中的属性排序
            let sectionNumber = collation.sectionForObject(str, collationStringSelector: Selector("name"))
            
            let sectionNames = newSectionsArray[sectionNumber]
            sectionNames.addObject(str)
            
        }
        
        let temp = NSMutableArray()
        
        newSectionsArray.enumerateObjectsUsingBlock { (arrArr, idx, stop) in
            
            let sortArr:NSArray =  arrArr as! NSArray
            
            if Bool(sortArr.count) {
                //不作处理
                
            } else {
                //将空数组添加到temp中
                temp.addObject(sortArr)
                
            }
            
        }
        newSectionsArray.removeObjectsInArray(temp as [AnyObject])
        
        
        
        
        return newSectionsArray
    }
    
}


extension ViewController: ABPeoplePickerNavigationControllerDelegate {
    //点击取消按钮
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController) {
        
        print("Cancle")
        
    }
    
    //点击联系人
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        /// 清空label
        phoneNumLbValue = ""
        /// 防止创建联系人时相关信息为空
        var ln: String = ""
        var fn: String = ""
        var localizedPhoneLabel: String = ""
        var phone: String = ""
        //获取姓
        if let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty) {
            ln = (lastName.takeRetainedValue() as? String) ?? ""
            
        }
        
        if let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty) {
            
            fn = (firstName.takeRetainedValue() as? String) ?? ""
            
            
        }
        nameLb.text = ln + fn
        
        let phoneValues:ABMutableMultiValueRef? =
            ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        
        if phoneValues != nil {
            for i in 0..<ABMultiValueGetCount(phoneValues) {
                
                // 获得标签名
                if let phoneLabel1 = ABMultiValueCopyLabelAtIndex(phoneValues, i) {
                    
                    let phoneLabel = phoneLabel1.takeRetainedValue() as CFStringRef
                    
                    // 转化为本地签名（即地点）
                    localizedPhoneLabel = ABAddressBookCopyLocalizedLabel(phoneLabel) .takeRetainedValue() as String
                    print("\(localizedPhoneLabel)")
                    phoneAdress.append(localizedPhoneLabel)
                }
                
                
                if let value = ABMultiValueCopyValueAtIndex(phoneValues
                    , i) {
                    phone = value.takeRetainedValue() as! String
                    
                    print(phone)
                    phoneNum.append(phone)
                    phoneNumLbValue = phoneNumLbValue + phone + "\n"
                }
                
            }
            
        }
        
        phoneNumLb.text = phoneNumLbValue
        
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord) -> Bool {
        
        return true
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        
        return true
    }
    
}



extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArr?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tablView?.dequeueReusableCellWithIdentifier("cellPig")
        
        let model = dataArr![indexPath.section] as! [GYModel]
        
        
        cell?.textLabel?.text = model[0].name
        
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return ["B","Y","Z"]
    }
    
    
}

