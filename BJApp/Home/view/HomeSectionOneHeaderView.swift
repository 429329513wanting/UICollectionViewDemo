//
//  HomeSectionOneHeaderView.swift
//  BJApp
//
//  Created by ghwang on 16/3/10.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit

class HomeSectionOneHeaderView: UICollectionReusableView {
    
    
    private var leftLab: UILabel = UILabel()
    private var rightLab: UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        leftLab.text = "新人专区"
        leftLab.font = UIFont .systemFontOfSize(16);
        
        rightLab.text = "新人特享，专人福利"
        rightLab.font = UIFont .systemFontOfSize(12);
        rightLab.textAlignment = NSTextAlignment.Right
        rightLab.textColor = UIColor.lightGrayColor()

        
        addSubview(leftLab)
        addSubview(rightLab)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        leftLab.frame = CGRectMake(10, 10, 200, 20)
        rightLab.frame = CGRectMake(self.width-210, 10, 200, 20)
    }
}

class HomeSectionTwoHeaderView: UICollectionReusableView {
    
    lazy private var imgBgView: UIImageView? = {
    
        let imgBgView = UIImageView(frame: self.bounds)
        
        imgBgView.backgroundColor = UIColor.clearColor()
        return imgBgView
    
    
    }()
    
    var imgUrl: String?{
    
        didSet{
        
            addSubview(self.imgBgView!)
            imgBgView?.sd_setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage())
        
        }
    
    }
    
    override init(frame: CGRect) {
     
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeSectionDefaultFooter: UICollectionReusableView {
    

    
    private func buildDefaultFooterView(){
    
        line.backgroundColor = UIColor.lightGrayColor()
        line.frame = CGRectMake(0, 0, ScreenWidth, 5)
        addSubview(line)
    
    }
    
    private var line:UIImageView = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
   
        buildDefaultFooterView()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class SectionThreeFooterView: UICollectionReusableView {
    
    private var cellBg: UIView = UIView()
    private var imgView: UIImageView = UIImageView()
    
    
    var data: NSArray?{
    
        didSet{
        
            imgView.frame = CGRectMake(0, -10, self.width, 40)
            imgView.sd_setImageWithURL(NSURL(string: "http://d06.res.meilishuo.net//img//_o//a8//8c//36ec42f5be313f466af5d6be9ea6_1080_120.cj.jpg_7502c6c1_s0_1080_120.jpg"), placeholderImage: UIImage())
            
            cellBg.frame = CGRectMake(0, 25, ScreenWidth, 80)
            
            for (var i=0;i<data?.count;i++){
            
                let cell: UIView = UIView(frame: CGRectMake(CGFloat(i)*self.width/3,0,self.width/3,80))
                let img: UIImageView = UIImageView()
                img.contentMode = UIViewContentMode.ScaleAspectFit
                img.frame = CGRectMake(5, 0, self.width/3-10, 80)
                cell.addSubview(img)
                cellBg.addSubview(cell)
                
                img.sd_setImageWithURL(NSURL(string: (data![i] as? String)!), placeholderImage: UIImage())
                
            }
            
            self.data = nil
            
        
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellBg)
        addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}