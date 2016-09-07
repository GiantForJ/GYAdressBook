//
//  ViewController.swift
//  GYContactsCustomUI
//
//  Created by zhuguangyang on 16/8/31.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import AddressBookUI

class ViewController: UIViewController {
    
    var dataArr: NSMutableArray? {
        didSet{
            tableView?.reloadData()
        }
    }
    
    var sectionTitles: NSMutableArray?{
        didSet {
            tableView?.reloadData()
        }
    }
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionTitles = NSMutableArray()
        
        
        tableView = UITableView(frame: view.frame)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        view.addSubview(tableView!)
        
        tableView?.registerClass(GYTConactCell.self, forCellReuseIdentifier: "cellID")
        
        let gyConact = GYConactBook()
        dataArr = gyConact.getAllPerson()
        setTileList()
        dataArr?.enumerateObjectsUsingBlock { (arrArr, idx, stop) in
            
            let sortArr:NSArray =  arrArr as! NSArray
            
            //            if Bool(sortArr.count) {
            let model = sortArr as? [GYPersonModel]
            
            //            print((model![0] as GYPersonModel).sectionNumber)
        }
        
        print(sectionTitles)
        //        for var i = 0; i < dataArr?.count;i += 1 {
        //            
        //            let modelArr = dataArr![i] as! [GYPersonModel]
        //            
        //            for person: GYPersonModel in modelArr {
        //                print(person.name1)
        //                print(person.sectionNumber)
        //                print(person.phoneNumber)
        //            }
        //            
        //        }
        
        
        
    }
    
    func setTileList() {
        let theCollation = UILocalizedIndexedCollation.currentCollation()
        sectionTitles?.removeAllObjects()
        //添加26个英文字母+#
        sectionTitles?.addObjectsFromArray(theCollation.sectionTitles)
        let existtitles = NSMutableArray()
        //清除掉空数组
        dataArr?.enumerateObjectsUsingBlock { (arrArr, idx, stop) in
            
            let sortArr:NSArray =  arrArr as! NSArray
            
            //            if Bool(sortArr.count) {
            let model = sortArr as? [GYPersonModel]
            
            //取出存在的索引
            existtitles.addObject(self.sectionTitles![model![0].sectionNumber])
            
            
        }
    
    
    self.sectionTitles?.removeAllObjects()
    self.sectionTitles = existtitles
    
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}



}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return dataArr?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return dataArr![section].count ?? 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! GYTConactCell
        
        let model = (dataArr![indexPath.section] as! [GYPersonModel])[indexPath.row] as GYPersonModel
        
        cell.reloadUI(model)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if self.sectionTitles == nil || self.sectionTitles?.count == 0 {
            return nil
        }
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.init(patternImage: UIImage(named: "1")!)
        
        let label = UILabel(frame: CGRectMake(10, 0, 100, 22))
        label.backgroundColor = UIColor.clearColor()
        label.text = sectionTitles?.objectAtIndex(section) as? String ?? ""
        contentView.addSubview(label)
        
        
        return contentView
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return NSArray(array: sectionTitles!) as? [String]
    }
    
}

