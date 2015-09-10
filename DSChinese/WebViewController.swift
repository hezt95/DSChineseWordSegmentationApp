//
//  WebViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/9/10.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit

var htmlURL: NSURL?

class WebViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = UIWebView()
        self.view.addSubview(webView)
        webView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        let req = NSURLRequest(URL: htmlURL!)
        webView.loadRequest(req)
        // Do any additional setup after loading the view.
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
