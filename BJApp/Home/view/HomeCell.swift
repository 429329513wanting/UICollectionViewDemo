//
//  HomeCell.swift
//  BJApp
//
//  Created by ghwang on 16/2/25.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UICollectionViewCell {

    lazy var bgImg :UIImageView = {
    
        let bgImg = UIImageView()
        bgImg.backgroundColor = UIColor.clearColor()
        return bgImg
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildSubViews()
        
    }
    
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildSubViews(){
    
        addSubview(bgImg)
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgImg.frame = CGRectMake(0,0,frame.width, frame.height)
    }
    
}

class SlideMenuCell: UICollectionViewCell {
    
    var btnClick:(UIButton) -> Void = {_ in }
    private var menuScrollerView: UIScrollView?
    
    var menuTitles: NSArray?{
    
        didSet{
            
            //防止滑动时复用问题
            if menuScrollerView != nil{
            
                return
            }
            menuScrollerView = UIScrollView(frame: self.bounds)
            addSubview(menuScrollerView!)
            menuScrollerView?.showsHorizontalScrollIndicator = false
            menuScrollerView?.showsVerticalScrollIndicator = false
            
            let line: UIImageView = UIImageView(frame: CGRectMake(0, 0, ScreenWidth, 5))
            line.backgroundColor = UIColor.lightGrayColor()
            menuScrollerView?.addSubview(line)
            
            for(var i = 0;i < menuTitles?.count;i++){
            
                let menBtn = UIButton(type: .Custom)
                menBtn.tag = 8080+i
                menBtn.addTarget(self, action: "btnnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                menBtn.frame = CGRectMake(CGFloat(10+i*(90+5)), 5, HomeMenuBtnWidthHeight, HomeMenuBtnWidthHeight)
                menBtn.backgroundColor = UIColor.clearColor()
                menBtn.setImage(UIImage(), forState: .Highlighted)
                menuScrollerView?.addSubview(menBtn)
                
                let ad: AD = menuTitles![i] as! AD
                
                menBtn.setBackgroundImageWithURL(NSURL(string: ad.pic_url!), forState: .Normal, placeholderImage: nil, completed: { (image, error, _) -> Void in
                    
                })
            }
            
            menuScrollerView?.contentSize = CGSizeMake(CGFloat( menuTitles!.count*100), self.height)
        }
    
    }
    
    func btnnClick(btn: UIButton){
    
        btnClick(btn)
    }
    
    
    override init(frame:CGRect){
        
        super.init(frame: frame)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
    }
}

class MeCell: UICollectionViewCell {
    
    private var noLogLab: UILabel = UILabel(frame: CGRectMake(10,5,200,18))
    private var cellBgView: UIView = UIView()
    
    var data: NSArray?{
    
        didSet{
        
            cellBgView.frame = self.bounds
            addSubview(cellBgView)

            
            for(var i = 0;i<data?.count;i++){
            
                let ue: UserEntity = data![i] as! UserEntity
                
                let cell: UIView = UIView(frame: CGRectMake(CGFloat(i)*self.width/4,30,self.width/4,self.width/4))
                cellBgView.addSubview(cell)
                
                let btn: UIButton = UIButton(type: .Custom)
                btn.backgroundColor = UIColor.clearColor()
                btn.frame = CGRectMake(15, 0, cell.width-30, cell.width-38)
                
                btn.sd_setBackgroundImageWithURL(NSURL(string: ue.pic_url!), forState: .Normal)
                cell.addSubview(btn)
            
            }
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        noLogLab.font = UIFont.systemFontOfSize(12)
        noLogLab.textColor = UIColor.lightGrayColor()
        noLogLab.text = "Hi,小主你还没用登陆"
        addSubview(noLogLab)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DayNewsSaleCell: UICollectionViewCell {
    
    private var leftImgView: UIImageView = UIImageView()
    private var rightView: UIView? = UIView()
    
    var data: NSDictionary?{
    
        didSet{
        
            //赋值
            
            leftImgView.frame = CGRectMake(5, 5, self.width/1.6, self.height-10)
            
            addSubview(leftImgView)
            
            let ad: AD = data!["left"] as! AD
            leftImgView.sd_setImageWithURL(NSURL(string: ad.pic_url!), placeholderImage: UIImage())
            

            
            rightView!.frame = CGRectMake(CGRectGetMaxX(leftImgView.frame)+2, 5, self.width-5-leftImgView.width-2, self.height-10)
            addSubview(rightView!)

            
            for (var i=0;i<data!["rights"]!.count;i++){
            
                let ad: AD = (data!["rights"]![i] as? AD)!
                let smlImgView = UIImageView(frame: CGRectMake(0, 4+CGFloat(i)*((rightView?.height)!/3+1)-5, (rightView?.width)!, (rightView?.height)!/3))
                smlImgView.contentMode = UIViewContentMode.ScaleAspectFit
                rightView?.addSubview(smlImgView)
                
                smlImgView.sd_setImageWithURL(NSURL(string: ad.pic_url!), placeholderImage: UIImage())
            
            }
            
        }
        
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

    
 
}