//
//  SettingViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/9/8.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow()
        self.title = "Setting"
        let btnLocationVBase = self.view.frame.height / 2 - 80 //the 4 target's base vertical location'
        let btnLocationVInterval = 70
        let loadDicBtn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase), title: "Load Dictionary")
        let downloadBtn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase + CGFloat(btnLocationVInterval)), title: "Download Contents")
        let testBtn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase + CGFloat(btnLocationVInterval * 2)), title: "Test")
        let test2Btn = HZTButton(parentView: self.view, locationV: Double(btnLocationVBase + CGFloat(btnLocationVInterval) * 3), title: "Test")
        loadDicBtn.addTarget(self, action: Selector("loadDicBtnDidSelect"), forControlEvents: UIControlEvents.TouchDown)
        downloadBtn.addTarget(self, action: Selector("downloadBtnDidSelect"), forControlEvents: UIControlEvents.TouchDown)
        
    }
    
    func loadDicBtnDidSelect() {
        
    }
    
    func downloadBtnDidSelect() {
        
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
