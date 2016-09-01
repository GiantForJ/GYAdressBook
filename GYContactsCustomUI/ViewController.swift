//
//  ViewController.swift
//  GYContactsCustomUI
//
//  Created by zhuguangyang on 16/8/31.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataArr: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gyConact = GYConactBook()
        dataArr = gyConact.getAllPerson()
       
        for var i = 0; i < dataArr?.count;i += 1 {
            
            let modelArr = dataArr![i] as! [GYPersonModel]
            
            for person: GYPersonModel in modelArr {
                print(person.name1)
                print(person.sectionNumber)
                print(person.phoneNumber)
            }
            
            
            
        }
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

