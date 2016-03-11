//
//  WebViewController.swift
//  BJApp
//
//  Created by ghwang on 16/3/11.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    private var web: UIWebView?
    
    var url: String?{
    
        didSet{
        
            web?.loadHTMLString(url!, baseURL: nil)
        
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        web = UIWebView()
        web?.frame = self.view.bounds
        view.addSubview(web!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
