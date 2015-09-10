//
//  MainTableViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/9/9.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit
import SnapKit

var dic = CWSDictionary()
var content = CWSContent()

class MainTableViewController: UITableViewController, UISearchResultsUpdating {
    var resultTableData = [String]()
    let searchCtrl = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chinese Word Segment"
        self.view.backgroundColor = UIColor.yellow()
        let settingBarBtnItem = UIBarButtonItem(title: "Setting", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("settingDidSelect"))
        let testBarBtnItem = UIBarButtonItem(title: "test", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("testDidSelect"))
        self.navigationItem.rightBarButtonItem = settingBarBtnItem
        self.navigationItem.leftBarButtonItem = testBarBtnItem
        // MARK: - SearchCtrl config
        searchCtrl.searchResultsUpdater = self
        searchCtrl.hidesNavigationBarDuringPresentation = false
        searchCtrl.searchBar.sizeToFit()
        searchCtrl.searchBar.placeholder = "请输入"
        searchCtrl.searchBar.translucent = true
        searchCtrl.searchBar.barTintColor = UIColor.yellow()
        tableView.tableHeaderView = searchCtrl.searchBar
        
        tableView.allowsSelection = true
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        resultTableData.removeAll(keepCapacity: false)
        let searchStr = searchCtrl.searchBar.text
        let searchTextHash = CWSContent.hash(searchStr)
        var searchArr = content.indexDic[searchTextHash]?.id
        if searchArr != nil {
            resultTableData = searchArr!
        }
        self.tableView.reloadData()
        
    }
    
    // MARK: - Btn
    func settingDidSelect() {
        let settingViewController = SettingViewController()
        self.navigationController!.pushViewController(settingViewController, animated: true)
        
    }
    
    func testDidSelect() {
        var webViewCtrl = WebViewController()
        htmlURL = NSURL(string: "http://www.jianshu.com/p/" + "f69e8a5ae4f9")
        self.navigationController!.pushViewController(webViewCtrl, animated: true)
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
        return resultTableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        println(searchCtrl.active)
        if searchCtrl.active {
            cell.textLabel?.text = resultTableData[indexPath.row]
            cell.backgroundColor = UIColor.yellow()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var webViewCtrl = WebViewController()
        htmlURL = NSURL(string: "http://www.jianshu.com/p/" + resultTableData[indexPath.row])
        self.navigationController!.pushViewController(webViewCtrl, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
