//
//  ResultTableViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/9/10.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var resultTableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow()
//        self.title = "Chinese Word Segment"
//        let settingBarBtnItem = UIBarButtonItem(title: "Setting", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("settingDidSelect"))
//        let testBarBtnItem = UIBarButtonItem(title: "test", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("testDidSelect"))
//        self.navigationItem.rightBarButtonItem = settingBarBtnItem
//        self.navigationItem.leftBarButtonItem = testBarBtnItem
//        // MARK: - SearchCtrl config
//        let navCtrl = UINavigationController(rootViewController: self)
        
        tableView.allowsSelection = true
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return content.id.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("resultCell") as! UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "resultCell")
        }
        if tableView == self.tableView {
        }
        
        cell.textLabel!.backgroundColor = UIColor.yellow()
        cell.textLabel!.text = resultTableData[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let htmlURL = NSURL(string: "http://www.jianshu.com/p/" + resultTableData[indexPath.row])
        var webViewCtrl = WebViewController(url: htmlURL!)
        self.navigationController!.pushViewController(webViewCtrl, animated: true)
    }
    
    // MARK: - about the nav ctrl
    
}
