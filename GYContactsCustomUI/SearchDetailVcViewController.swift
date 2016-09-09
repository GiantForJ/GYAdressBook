//
//  SearchDetailVcViewController.swift
//  GYAdressBook
//
//  Created by zhuguangyang on 16/9/8.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class SearchDetailVcViewController: UITableViewController {
    
    var resultArr:[GYPersonModel]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🐖"
        tableView?.registerClass(GYTConactCell.self, forCellReuseIdentifier: "cellID1")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArr?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = resultArr![indexPath.row]
        
        print(model.name1)
        
        let showVc = ShowViewController()

        print(self.navigationController?.viewControllers)
        self.navigationController?.pushViewController(showVc, animated: true)
        
//
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID1") as! GYTConactCell
        
        let model = resultArr![indexPath.row]
        
        cell.reloadUI(model)
        
        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
}
