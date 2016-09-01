//
//  AppDelegate.swift
//  GYAdressBook
//
//  Created by zhuguangyang on 16/8/30.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import AddressBook

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //获取授权状态
        let status = ABAddressBookGetAuthorizationStatus()
        
        //创建addressbook
        let addressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        let arr = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        /*
         kABAuthorizationStatusNotDetermined  用户未选择，用户还没有决定是否授权你的程序进行访问
         kABAuthorizationStatusRestricted iOS设备上一些许可配置阻止程序与通讯录数据库进行交互
         kABAuthorizationStatusDenied  用户明确的拒绝了你的程序对通讯录的访问
         kABAuthorizationStatusAuthorized  用户已经授权给你的程序对通讯录进行访问
         */
        //授权
        if status == ABAuthorizationStatus.NotDetermined {
            
            //
            ABAddressBookRequestAccessWithCompletion(addressBook, { (granted, error) in
                
                if (error != nil) {
                    
                    return
                }
                
                //判断是否授权
                if granted {
                    
                    print("已授权")
                     let arr = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
                    print(arr)
                    
                } else {
                    print("未授权")
                }
                
            })
            
      
        }

        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

