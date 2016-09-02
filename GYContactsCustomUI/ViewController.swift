//
//  ViewController.swift
//  GYContactsCustomUI
//
//  Created by zhuguangyang on 16/8/31.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataArr: NSMutableArray? {
        didSet{
            tableView?.reloadData()
        }
    }
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        view.addSubview(tableView!)
        
        tableView?.registerClass(GYTConactCell.self, forCellReuseIdentifier: "cellID")
        
        let gyConact = GYConactBook()
        dataArr = gyConact.getAllPerson()
        
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
   
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
}

