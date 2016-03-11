//
//  HomeHeaderView.swift
//  BJApp
//
//  Created by ghwang on 16/3/9.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    private var imageViewScrollView: ZLImageViewDisplayView?
    var data: NSDictionary?{
    
    
        didSet{
        
            let imgUrls: NSMutableArray = NSMutableArray()
            let ads: NSArray = (data!["ads"] as? NSArray)!
            for ad in ads{
                
                let ad: AD = (ad as? AD)!
                
                imgUrls.addObject(ad.pic_url!)
                
            }
            
           imageViewScrollView = ZLImageViewDisplayView(frame: CGRectMake(0, 0, ScreenWidth, self.height), withImages: imgUrls as [AnyObject])
            
            addSubview(imageViewScrollView!)
            
        
        }
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGrayColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
    }

}
