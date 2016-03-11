//
//  HomeData.swift
//  BJApp
//
//  Created by ghwang on 16/3/10.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit

class HomeData: NSObject {

    static var result: NSMutableDictionary = NSMutableDictionary()
    static var newsSales: NSMutableArray = NSMutableArray()
    
    class func loadHomeData(completetion:(data: NSDictionary?,error:NSError?) -> Void){
    
        
        let path = NSBundle.mainBundle().pathForResource("home_prototype.json", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            
            let list: NSArray = dict["data"]!["list"] as! NSArray
            
            for dic in list{
                
                let type: String = (dic["desc"]!!["type"] as? String)!
                
                
                if type == "slide"{ // 广告数据
                    
                    let array: NSArray = (dic["data"] as? NSArray)!
                    let ads = modelTool.objectsWithArray(array, cls: AD.self)
                    result.setObject(ads!, forKey: "ads")
                    
                }else if type == "scroll"{ // 滚动菜单
                
                    let array: NSArray = (dic["data"] as? NSArray)!
                    let ads = modelTool.objectsWithArray(array, cls: AD.self)
                    result.setObject(ads!, forKey: "scrollMenu")
                
                }else if type == "special_for_me" {
                
                    let array: NSArray = dic["data"]!!["entries"] as! NSArray
                    let ens = modelTool.objectsWithArray(array, cls: UserEntity.self)
                    result.setObject(ens!, forKey: "userItems")
                
                }else if type == "vertical"{
                
                    let array: NSArray = (dic["data"] as? NSArray)!
                    
                    let left = modelTool.objectWithDictionary((array.firstObject?.firstObject as? NSDictionary)!, cls: AD.self)
                    let rights = modelTool.objectsWithArray(array[1] as! NSArray, cls: AD.self)
                    newsSales.addObject(["left":left!,"rights":rights!])
                    result.setObject(newsSales, forKey: "dayNewsSale")
                
                }
            }
            

            
            
            //开始解析数据
            
            
            completetion(data: result, error: nil)
            
        }
        
        
        
    }
}


class AD: NSObject {
    
     var pic_url: String?
     var pic_height: String?
     var pic_width: String?
     var title: String?
     var url: String?
     var r: String?
    
}

class UserEntity: NSObject {
  
    var notLoad: String?

    var userName: String?

    var userIcon: String?

    var pic_height: String?

    var title: String?

    var genes: String?

    var r: String?

    var pic_width: String?

    var url: String?
    
    var pic_url: String?
    
}