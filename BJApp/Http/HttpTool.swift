//
//  HttpTool.swift
//  BJApp
//
//  Created by ghwang on 16/2/24.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

typealias Success = (result: AnyObject?) -> Void
typealias Fail = (fail: NSError?) -> Void


//此类已废弃，临时封装的一个接口 首页数据是json文件

class HttpTool: NSObject {


    class func GetRequest(paramters paramters: [String:String]?,url: String,success: Success,fail: Fail){
    

        MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().keyWindow, animated: true)
        Alamofire.request(.GET,Host+"/"+url,parameters:paramters).response { (request,response,data,error) -> Void in
            
           MBProgressHUD.hideHUDForView(UIApplication.sharedApplication().keyWindow, animated: false)
            if data != nil{
            
                print("=====================\(String(data: data!, encoding: 4)))")
 
                let dict = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                
                
                print("responseJson=== \(dict.JSONValue)")
                
                if dict["returncode"]?.intValue != 0{
                
                    print("data error \n\(dict["message"])")
                    
                }else{
                
                    success(result: dict["result"])

                }
                
                
            }else{
            
                print("网络错误")
                fail(fail:error)
            }
        }
    
    }
    
    class func PostRequest(paramters: [String:String]?,url: String,success: Success,fail: Fail){
        
        
        MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().keyWindow, animated: true)
        Alamofire.request(.POST,Host+"/"+url,parameters:paramters).response { (request,response,data,error) -> Void in
            
            MBProgressHUD.hideHUDForView(UIApplication.sharedApplication().keyWindow, animated: false)
            if data != nil{
                
                print("=====================\(String(data: data!, encoding: 4)))")
                
                let dict = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                
                
                print("responseJson=== \(dict.JSONValue)")
                
                if dict["returncode"]?.intValue != 0{
                    
                    print("data error \n\(dict["message"])")
                    
                }else{
                    
                    success(result: dict["result"])
                    
                }
                
                
            }else{
                
                print("网络错误")
                fail(fail:error)
            }
        }
        
    }
}

extension NSDictionary{

    var JSONValue: String{
    
        let data = (try! NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions.PrettyPrinted)) 
    
        return String(data: data, encoding: 4)!
    
    }

}