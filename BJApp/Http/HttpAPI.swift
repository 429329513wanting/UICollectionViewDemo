//
//  HttpAPI.swift
//  BJApp
//
//  Created by ghwang on 16/2/24.
//  Copyright © 2016年 ghwang. All rights reserved.
//


//此类已废弃，临时封装的一个接口，首页数据是json文件

import UIKit

class HttpAPI: NSObject {
    
    class func getMyFavs(paramaters: [String:String],success: Success,fail: Fail){
    
        HttpTool.GetRequest(paramters:paramaters, url: "priceapi4.0.1/services/user/getfavseries",
            
            success: {(result) in
            
                print("success")
                print("resultDic\n\(result)")
                
                let cars = result!["serieslist"] as! NSArray
                let mcars = DictModelManager.sharedManager.objectsWithArray(cars, cls: Car.self)
                //处理模型数据
                success(result: mcars)
            },
            
            fail: {(error) in
                
                print("error")
                fail(fail: error)
                
        
        })
    }

    class func carDetailInfo(paramaters: [String:String],success: Success,fail: Fail){
    
        HttpTool.PostRequest(paramaters, url: "priceapi4.0.1/services/seriessummary",
            
            success: {(result) in
            
                print("success")
                print("resultDic\n\(result)")

            },
            
            fail: {(error) in
                
                print("error")
                fail(fail: error)
                
        
        })
    }


}
