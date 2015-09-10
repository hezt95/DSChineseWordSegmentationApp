//
//  SettingViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/9/8.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit
import MONActivityIndicatorView

class SettingViewController: UIViewController, MONActivityIndicatorViewDelegate {
    var indicatorView: MONActivityIndicatorView
    var loadDicBtn: HZTButton
    var downloadBtn: HZTButton
    var testBtn: HZTButton
    var test2Btn:HZTButton
    
    init() {
        indicatorView = MONActivityIndicatorView()
        loadDicBtn = HZTButton()
        downloadBtn = HZTButton()
        testBtn = HZTButton()
        test2Btn = HZTButton()
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        
        let btnLocationVBase = self.view.frame.height / 2 - 80 //the 4 target's base vertical location'
        let btnLocationVInterval = 70
        loadDicBtn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase), title: "Load Dictionary")
        downloadBtn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase + CGFloat(btnLocationVInterval)), title: "Load Contents")
        testBtn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase + CGFloat(btnLocationVInterval * 2)), title: "Test")
        test2Btn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase + CGFloat(btnLocationVInterval) * 3), title: "Test")
        loadDicBtn.addTarget(self, action: Selector("loadDicBtnDidSelect"), forControlEvents: UIControlEvents.TouchDown)
        downloadBtn.addTarget(self, action: Selector("downloadBtnDidSelect"), forControlEvents: UIControlEvents.TouchDown)
        
        self.view.addSubview(indicatorView)
        indicatorView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(140)
        }
        indicatorView.numberOfCircles = 5
        indicatorView.radius = 20
        indicatorView.internalSpacing = 3
        indicatorView.delay = 0.5
        indicatorView.delegate = self
        indicatorView.duration = 0.5
    }
    
    func activityIndicatorView(activityIndicatorView: MONActivityIndicatorView!, circleBackgroundColorAtIndex index: UInt) -> UIColor! {
        var red = CGFloat(Double(arc4random() % 256)/255.0)
        var green = CGFloat(Double(arc4random() % 256)/255.0)
        var blue = CGFloat(Double(arc4random() % 256)/255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    func loadDicBtnDidSelect() {
        
        //start the load dictionary process
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            println("start work background")
            self.loadDicBtn.enabled = false
            self.downloadBtn.enabled = false
            self.testBtn.enabled = false
            self.test2Btn.enabled = false
            self.navigationItem.hidesBackButton = true
            dic = CWSDictionary()
            dic.loadDic()
            dispatch_async(dispatch_get_main_queue(), {
                //stop the animation,return the main thread
                println("stop work background")
                self.loadDicBtn.enabled = true
                self.downloadBtn.enabled = true
                self.testBtn.enabled = true
                self.test2Btn.enabled = true
                self.navigationItem.hidesBackButton = false
                self.indicatorView.stopAnimating()
            })
        })
        //start the animation
        println("start animating")
        self.indicatorView.startAnimating()
    }
    
    func downloadBtnDidSelect() {
        if dic.fullDic.isEmpty {
            let alartView = UIAlertView(title: "Error", message: "Please load a dictionary", delegate: nil, cancelButtonTitle: "OK")
            alartView.show()
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            println("start work background")
            self.loadDicBtn.enabled = false
            self.downloadBtn.enabled = false
            self.testBtn.enabled = false
            self.test2Btn.enabled = false
            self.navigationItem.hidesBackButton = true
            content.loadAndSegment(use: dic)
            dispatch_async(dispatch_get_main_queue(), {
                //stop the animation,return the main thread
                println("stop work background")
                self.loadDicBtn.enabled = true
                self.downloadBtn.enabled = true
                self.testBtn.enabled = true
                self.test2Btn.enabled = true
                self.navigationItem.hidesBackButton = false
                var indexStr = String()
                for (hash, index) in content.indexDic {
                    indexStr = indexStr + "\(hash): \(index.key)\n"
                    for item in index.id {
                        indexStr = indexStr + item + " "
                    }
                    indexStr = indexStr + "\n"
                }
                print(indexStr)
                //save to file
                var error: NSErrorPointer = nil
                indexStr.writeToFile(indexSavePath, atomically: true, encoding: NSUTF8StringEncoding, error: error)
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
