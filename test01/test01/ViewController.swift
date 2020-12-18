//
//  ViewController.swift
//  test01
//
//  Created by ZH_RaySharp on 2020/5/8.
//  Copyright © 2020 ZH_RaySharp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    let images = ["1", "2", "3", "4", "5"]
    let width = UIScreen.main.bounds.width
    var index = 0
    var leftImage, midImage, rightImage : UIImageView?
    var pagecontrol = UIPageControl()
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        self.setupU()
    }
    
    func setupU() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = false;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.contentSize = CGSize(width: 5*width, height: width)
        scrollView.contentOffset = CGPoint(x: width, y: 0)
        self.view.addSubview(scrollView)
        
        pagecontrol = UIPageControl(frame: CGRect(x: 0, y: width, width: width, height: 20))
        pagecontrol.numberOfPages = images.count
        pagecontrol.isUserInteractionEnabled = false
        self.view.addSubview(pagecontrol)
        
        leftImage = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        midImage = UIImageView(frame: CGRect(x: width, y: 0, width: width, height: width))
        rightImage = UIImageView(frame: CGRect(x: width*2, y: 0, width: width, height: width))
        scrollView.addSubview(leftImage!)
        scrollView.addSubview(midImage!)
        scrollView.addSubview(rightImage!)
        self.setImage()
    }
}

extension ViewController{
    func setImage() {
        if index == 0 {
            leftImage?.image = UIImage(named: images.last!)
            midImage?.image = UIImage(named: images.first!)
            rightImage?.image = UIImage(named: images[1])
        }else if index == images.count - 1 {
            leftImage?.image = UIImage(named: images[3])
            midImage?.image = UIImage(named: images.last!)
            rightImage?.image = UIImage(named: images.first!)
        }else{
            leftImage?.image = UIImage(named: images[index - 1])
            midImage?.image = UIImage(named: images[index])
            rightImage?.image = UIImage(named: images[index + 1])
        }
    }
}

extension ViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.x >= width * 2 {
            scrollView.contentOffset = CGPoint(x: width, y: 0)
            index += 1
            if index == images.count{
                index = 0
            }
        }
        if offset.x <= 0{
            scrollView.contentOffset = CGPoint(x: width, y: 0)
            index -= 1
            if index == -1{
                index = images.count - 1
            }
        }
        setImage()
        self.pagecontrol.currentPage = index;
    }
}
