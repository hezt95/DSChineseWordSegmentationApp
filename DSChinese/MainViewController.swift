//
//  MainViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/7/9.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit
import SnapKit
import MONActivityIndicatorView

var dic = CWSDictionary()
var content = CWSContent()

class MainViewController: UIViewController, MONActivityIndicatorViewDelegate {
    var indicatorView: MONActivityIndicatorView
    
    init() {
        indicatorView = MONActivityIndicatorView()
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activityIndicatorView(activityIndicatorView: MONActivityIndicatorView!, circleBackgroundColorAtIndex index: UInt) -> UIColor! {
        var red = CGFloat(Double(arc4random() % 256)/255.0)
        var green = CGFloat(Double(arc4random() % 256)/255.0)
        var blue = CGFloat(Double(arc4random() % 256)/255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CWS"
        self.view.backgroundColor = UIColor.yellow()
        let settingBarBtnItem = UIBarButtonItem(title: "Setting", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("settingDidSelect"))
        let testBarBtnItem = UIBarButtonItem(title: "test", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("testDidSelect"))
        self.navigationItem.rightBarButtonItem = settingBarBtnItem
        self.navigationItem.leftBarButtonItem = testBarBtnItem
        self.view.addSubview(indicatorView)
        indicatorView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        indicatorView.numberOfCircles = 5
        indicatorView.radius = 20
        indicatorView.internalSpacing = 3
        indicatorView.delay = 0.5
        indicatorView.delegate = self
        indicatorView.duration = 0.5
        
    }
    
    func settingDidSelect() {
        let settingViewController = SettingViewController()
        self.navigationController!.pushViewController(settingViewController, animated: true)

    }
    
    func testDidSelect() {
        //        dic.loadDic()
        //        content.loadAndSegment(use: dic)
        //        for (hash, index) in content.indexDic {
        //            println("\(hash): \(index.key)")
        //            for item in index.id {
        //                print(item)
        //                print(" ")
        //            }
        //            print("\n")
        //        }
        let loadQueue = dispatch_queue_create("loadQueue", nil)
        //start the load dictionary process
        dispatch_async(loadQueue, {
            println("start work background")
            dic.loadDic()
            dispatch_async(dispatch_get_main_queue(), {
                //stop the animation,return the main thread
                println("stop work background")
                self.indicatorView.stopAnimating()
            })
        })
        //start the animation
        println("start animating")
        self.indicatorView.startAnimating()
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
