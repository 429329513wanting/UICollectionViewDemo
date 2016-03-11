//
//  HomeViewController.swift
//  BJApp
//
//  Created by ghwang on 16/2/25.
//  Copyright © 2016年 ghwang. All rights reserved.
//

import UIKit
import RQShineLabel

class HomeViewController: UIViewController {

    private var adImageView: UIImageView?
    private var shineLab: RQShineLabel?
    private var collectionView: UICollectionView?
    
    var userItems: NSArray?
    var dayNewsSales: NSArray?
    
    var scrollMenus: NSArray?{
    
        didSet{
        
            
            self.collectionView?.reloadData()
        
        }
    
    }
    
    
    var adImage: UIImage?{
    
        didSet{
        
            adImageView = UIImageView()
            adImageView!.frame = ScreenBounds
            adImageView!.contentMode = UIViewContentMode.ScaleAspectFill
            adImageView!.image = adImage

            view.addSubview(adImageView!)
            
            shineLab = RQShineLabel(frame: CGRectMake(16,16,300,300))
            shineLab?.numberOfLines = 0
            shineLab?.font = UIFont.systemFontOfSize(16)
            shineLab?.text = "coder:ghwang\nps:闲暇时间自己模仿美丽说app,基于swift语言"
            shineLab?.backgroundColor = UIColor.clearColor()
            shineLab?.sizeToFit()
            shineLab?.center = (adImageView?.center)!
            adImageView?.addSubview(shineLab!)
            shineLab?.shineWithCompletion({ () -> Void in
                
                sleep(2)
                weak var tmpSelf = self
                UIImageView.animateWithDuration(2.0, animations: { () -> Void in
                    tmpSelf!.adImageView!.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    tmpSelf!.adImageView!.alpha = 0
                    }) { (finsch) -> Void in
                        tmpSelf!.adImageView!.removeFromSuperview()
                        tmpSelf?.adImageView = nil
                        self.navigationController?.navigationBarHidden = false
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "美丽说"
        buildCollectionView()
        
        HomeData.loadHomeData { (data, error) -> Void in
            
            self.buildTableHeaderView(data)
            
            self.userItems = data!["userItems"] as? NSArray
            self.dayNewsSales = data!["dayNewsSale"] as? NSArray
            self.scrollMenus = data!["scrollMenu"] as? NSArray
            
        }
        
    }
    
    func buildCollectionView(){
    
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        //layout.minimumLineSpacing = 10
        //layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), collectionViewLayout: layout )
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.registerClass(SlideMenuCell.self, forCellWithReuseIdentifier: "slideMenuCell")
        
        collectionView?.registerClass(MeCell.self, forCellWithReuseIdentifier: "MeCell")
        collectionView?.registerClass(DayNewsSaleCell.self, forCellWithReuseIdentifier: "DayNewCell")
        
        collectionView?.registerClass(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.registerClass(HomeSectionOneHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "OneSectionHeader")
        collectionView?.registerClass(HomeSectionTwoHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoSectionHeader")
        
        collectionView?.registerClass(HomeSectionDefaultFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "DefaultFooter")
        collectionView?.registerClass(SectionThreeFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "SectionThreeFooter")
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        view.addSubview(collectionView!)
        
        

        //collectionView!.setContentOffset(CGPoint(x: 0, y: -(collectionView!.contentInset.top)), animated: false)

    
    }
    
    func buildTableHeaderView(data: NSDictionary?){
    
    
        let headerView: HomeHeaderView = HomeHeaderView(frame: CGRectMake(0,-HomeHeaderViewHeight,ScreenWidth,HomeHeaderViewHeight))

        collectionView?.addSubview(headerView)
        headerView.data = data!
        collectionView?.contentInset = UIEdgeInsetsMake(150, 0, 0, 0)
    }

}

extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
    
    
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section{
        
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3,4:
            return 2
        default:
            return 4
            
        }
    }
    
    
    //Item高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        switch indexPath.section{
            
        case 0:
            
            return CGSizeMake(ScreenWidth, 100)
            
        case 1:
            return CGSizeMake(ScreenWidth, 200)
        
        case 2:
           return CGSizeMake(ScreenWidth, 100)
        case 3,4:
            return CGSizeMake(ScreenWidth, 290)
        default:
             return CGSizeMake(100, 100)
        }
        
        return CGSizeZero
    }
    
    //返回页眉或页脚
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        
        if indexPath.section == 1 && kind == UICollectionElementKindSectionHeader{
        
            let header: HomeSectionOneHeaderView =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "OneSectionHeader", forIndexPath: indexPath) as! HomeSectionOneHeaderView
            
            return header
            
        }else if indexPath.section == 2 && kind == UICollectionElementKindSectionHeader{
        
        
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoSectionHeader", forIndexPath: indexPath) as! HomeSectionTwoHeaderView
            
            return header
            
        }else if indexPath.section == 3 && kind == UICollectionElementKindSectionHeader{
        
            
        
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoSectionHeader", forIndexPath: indexPath) as! HomeSectionTwoHeaderView
            header.imgUrl = "http://d02.res.meilishuo.net//img//_o//1c//7d//276abddc4a4fb54bcf61dbffdeb0_1080_196.cj.jpg_84455a6e_s0_1080_196.jpg"
            return header
        }else if indexPath.section == 4 && kind == UICollectionElementKindSectionHeader{
        
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoSectionHeader", forIndexPath: indexPath) as! HomeSectionTwoHeaderView
            header.imgUrl = "http://d02.res.meilishuo.net//img//_o//1c//7d//276abddc4a4fb54bcf61dbffdeb0_1080_196.cj.jpg_84455a6e_s0_1080_196.jpg"
            return header
        
        }else if indexPath.section == 3 && kind == UICollectionElementKindSectionFooter{
        
            let footer: SectionThreeFooterView =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "SectionThreeFooter", forIndexPath: indexPath) as! SectionThreeFooterView
            footer.data = ["http://d06.res.meilishuo.net//img//_o//ff//39//d5fb5ed7fb6728c2bd2755bcee43_340_204.cj.png","http://d06.res.meilishuo.net//img//_o//49//ee//238723ef10d5044f79954c50d83f_340_204.cj.png","http://d03.res.meilishuo.net//img//_o//07//60//581800b66c6b7e5df6bcfb8f1729_340_204.cj.jpg_98144a68_s0_340_204.jpg"]
            
            return footer
        
        }
        
        
        let footer: HomeSectionDefaultFooter =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "DefaultFooter", forIndexPath: indexPath) as! HomeSectionDefaultFooter
        

        
        return footer
        

        
    }
    //页眉高度
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
    
        switch section{
        
        case 0:
            return CGSizeMake(ScreenWidth, 0)
        case 1:
            return CGSizeMake(ScreenWidth, 45)
        case 2:
            return CGSizeMake(ScreenWidth, 0)
        case 3, 4:
            return CGSizeMake(ScreenWidth, 60)
        default:
            return CGSizeMake(ScreenWidth, 10)
        }
    
    }
    
    //页脚高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        switch section{
        
        case 3:
            return CGSizeMake(ScreenWidth, 120)
        default:
            return CGSizeMake(0, 5)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == 0{
        
            let cell: SlideMenuCell = collectionView.dequeueReusableCellWithReuseIdentifier("slideMenuCell", forIndexPath: indexPath) as! SlideMenuCell
            
            cell.btnClick = {btn in
            
                let web: WebViewController = WebViewController()
                
                let ad: AD = self.scrollMenus![btn.tag - 8080] as! AD
                web.url = ad.url
                self.navigationController?.pushViewController(web, animated: true)
                
                
            }
            
            cell.menuTitles = self.scrollMenus
            return cell
        
        }else if indexPath.section == 1{
        
       
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeCell
            let bgImageView: UIImageView = UIImageView(image: UIImage(named: "section1_bg.jpg"))
            bgImageView.frame = CGRectMake(5, 0, cell.width-10, cell.height-10)
            cell.addSubview(bgImageView)
            
            return cell
        
        }else if indexPath.section == 2{
        
            let cell: MeCell = collectionView.dequeueReusableCellWithReuseIdentifier("MeCell", forIndexPath: indexPath) as! MeCell
            
            cell.data = self.userItems
            return cell
        
        }else if indexPath.section == 3{
        
            let cell: DayNewsSaleCell = collectionView.dequeueReusableCellWithReuseIdentifier("DayNewCell", forIndexPath: indexPath) as! DayNewsSaleCell
            
            cell.data = self.dayNewsSales![indexPath.row] as? NSDictionary
            return cell
        
        }
        
        else{
        
            let cell: DayNewsSaleCell = collectionView.dequeueReusableCellWithReuseIdentifier("DayNewCell", forIndexPath: indexPath) as! DayNewsSaleCell
            
            cell.data = self.dayNewsSales![indexPath.row] as? NSDictionary
            return cell
        
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0{
        

        }
    }

}

