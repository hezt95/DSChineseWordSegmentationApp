//
//  MainViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/7/9.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit
import SnapKit

var dic = CWSDictionary()
var content = CWSContent()

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CWS"
//        MainViewController.creatDic()
        let loadDicBarBtnItem = UIBarButtonItem(title: "LoadDic", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("loadDic"))
        self.navigationItem.rightBarButtonItem = loadDicBarBtnItem
    }
    
    func loadDic() {
        dic.loadDic()
        content.loadAndSegment(use: dic)
        for (hash, index) in content.indexDic {
            println("\(hash): \(index.key)")
            for item in index.id {
                print(item)
                print(" ")
            }
            print("\n")
        }
    //    system("say Mission Complete")
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
