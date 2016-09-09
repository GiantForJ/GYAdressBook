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
    
    var filterCandies: NSMutableArray?
    
    var tableView: UITableView?
    
    var allArr: NSMutableArray?
    var searchBar: NSArray = []
    
    var allSet: NSMutableSet?
    
    
    var searchController: UISearchController?
    
    var resultVC: SearchDetailVcViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        initData()
        
        
        
    }
    
    func initUI() {
        
        
        tableView = UITableView(frame: view.frame)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        resultVC = SearchDetailVcViewController()
        let nav1 =  UINavigationController.init(rootViewController: resultVC!)
        nav1.navigationBarHidden = true
        tableView?.estimatedRowHeight = 60
        
        
        searchController = UISearchController(searchResultsController: nav1)
        searchController?.searchResultsUpdater = self
        //取消暗化上一个view
        self.searchController?.dimsBackgroundDuringPresentation = true
        //        searchController?.searchBar.sizeToFit()
        //设置definesPresentationContext为true，我们保证在UISearchController在激活状态下用户push到下一个view controller之后search bar不会仍留在界面上。
        definesPresentationContext = true
        //        //        searchBar = UISearchBar()
        //        searchBar?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44)
        tableView?.tableHeaderView = searchController?.searchBar
        
        view.addSubview(tableView!)
        
        tableView?.registerClass(GYTConactCell.self, forCellReuseIdentifier: "cellID")
    }
    
    
    func initData() {
        
        sectionTitles = NSMutableArray()
        allArr = NSMutableArray()
        allSet = NSMutableSet()
        
        
        let gyConact = GYConactBook()
        dataArr = gyConact.getAllPerson()
        setTileList()
        
        for item in dataArr! {
            
            for subItem in item as! [GYPersonModel] {
                
                allArr?.addObject(subItem)
                allSet?.addObject(subItem)
                
            }
            
        }
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.tableView {
            
        } else {
            let show = ShowViewController()
            
            navigationController?.pushViewController(show, animated: true)
        }

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

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        print(searchController.searchBar.text)
        
        guard searchController.searchBar.text != "" else {
            return
        }
        
        //谓词
        let pred = NSPredicate.init(format:"name1 CONTAINS %@",searchController.searchBar.text!)
        
        let result = allArr?.filteredArrayUsingPredicate(pred) as! [GYPersonModel]
        dataArr?.addObjectsFromArray(result)
        
        resultVC?.resultArr = result
        
        print(result)
        
    }
    
    
    
    
    
    
}
