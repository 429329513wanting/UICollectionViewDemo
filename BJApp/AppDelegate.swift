//
//  AppDelegate.swift
//  BJApp
//
//  Created by ghwang on 16/2/24.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let frame: CGRect = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        window?.makeKeyAndVisible()
        
        //
        showAnimationAD()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "adImageSuccess:", name: ADImageLoadSecussed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "adImageFail", name: ADImageLoadFail, object: nil)

        
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
    deinit{
    
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ADImageLoadSecussed, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ADImageLoadFail, object: nil)
    }


    /**
     AD广告闪屏
     */
    private func showAnimationAD(){
       
        let ad: ADViewController = ADViewController()
        ad.imageName = "http://d02.res.meilishuo.net//pic//_o//f3//97//3574a1c3204e32a671e3dae9ebbb_640_1136.cj.jpg";
        self.window?.rootViewController = ad
    }
    
    func adImageSuccess(notify: NSNotification){
        
        let image = notify.object as? UIImage
        let home = HomeViewController()
        home.adImage = image
        let nav = UINavigationController(rootViewController: home)
        nav.navigationBarHidden = true
        self.window?.rootViewController = nav
    }
    
    func adImageFail(){
        
    

    }

}

