//
//  WebViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/9/10.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit


class WebViewController: UIViewController,UIWebViewDelegate {
    var htmlURL: NSURL?
    let webView = UIWebView()
    init(url: NSURL){
        htmlURL  = url
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Up", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backBarBtnDidSelect"))
        self.view.addSubview(webView)
        webView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        let req = NSURLRequest(URL: htmlURL!)
        webView.loadRequest(req)
    }
    
    func backBarBtnDidSelect() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        let title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.title = title
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let title = "Loading"
        self.title = title
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        let alartView = UIAlertView(title: "Connection Error", message: "Cannot load the web", delegate: nil, cancelButtonTitle: "OK")
        alartView.show()
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
