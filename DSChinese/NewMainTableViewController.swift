//
//  NewMainTableViewController.swift
//  DSChinese
//
//  Created by He Zitong on 15/9/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import UIKit
import SnapKit


class NewMainTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    var displayData: [String]
    var searchCtrl: UISearchController!
    
    init() {
        displayData = [String]()
        searchCtrl = UISearchController(searchResultsController: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chinese Word Segment"
        let settingBarBtnItem = UIBarButtonItem(title: "Setting", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("settingDidSelect"))
        let testBarBtnItem = UIBarButtonItem(title: "test", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("testDidSelect"))
        self.navigationItem.rightBarButtonItem = settingBarBtnItem
        self.navigationItem.leftBarButtonItem = testBarBtnItem
            }
    override func viewWillAppear(animated: Bool) {
        // MARK: - SearchCtrl config
        searchCtrl.searchBar.delegate = self
        searchCtrl.searchResultsUpdater = self
        searchCtrl.hidesNavigationBarDuringPresentation = false
        searchCtrl.searchBar.sizeToFit()
        searchCtrl.searchBar.placeholder = "OR:A|B AND:A&B"
        searchCtrl.searchBar.translucent = true
        searchCtrl.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchCtrl.searchBar
        
        tableView.allowsSelection = true
        tableView.reloadData()
 
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.searchCtrl.active {
            self.searchCtrl.active = false
            self.searchCtrl.searchBar.removeFromSuperview()
        }
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        displayData.removeAll(keepCapacity: false)
        let searchStr = searchCtrl.searchBar.text
        enum Operator {
            case And
            case Or
            case Nothing
        }
        var op = Operator.Nothing
        for char in searchStr {
            if char == Character("|") {
                op = Operator.Or
            }
            if char == Character("&") {
                op = Operator.And
            }
        }
        switch op {
        case .And:
            var searchStrArr = searchStr.componentsSeparatedByString("&")
            var searchSetArr = [Set<String>]()
            for item in searchStrArr {
                let searchTextHash = CWSContent.hash(item)
                var searchArr = content.indexDic[searchTextHash]?.id
                if searchArr != nil {
                    searchSetArr.append(Set(searchArr!))
                } else {
                    self.displayData = Array()
                    self.tableView.reloadData()
                    return
                }
            }
            var searchSet = Set<String>()
            for var i = 0; i < searchSetArr.count; i++ {
                if i == 0 {
                    searchSet = searchSetArr[i]
                } else {
                    searchSet.intersect(searchSetArr[i])
                }
            }
            self.displayData = Array(searchSet)

        case .Or:
            var searchStrArr = searchStr.componentsSeparatedByString("|")
            var searchSetArr = [Set<String>]()
            for item in searchStrArr {
                let searchTextHash = CWSContent.hash(item)
                var searchArr = content.indexDic[searchTextHash]?.id
                if searchArr != nil {
                    searchSetArr.append(Set(searchArr!))
                }
            }
            var searchSet = Set<String>()
            for var i = 0; i < searchSetArr.count; i++ {
                if i == 0 {
                    searchSet = searchSetArr[i]
                } else {
                    searchSet.union(searchSetArr[i])
                }
            }
            self.displayData = Array(searchSet)
        case .Nothing:
            let searchTextHash = CWSContent.hash(searchStr)
            var searchArr = content.indexDic[searchTextHash]?.id
            if searchArr != nil {
                self.displayData = searchArr!
            }
        }
        
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
   
    // MARK: - Btn
    func settingDidSelect() {
        let settingViewController = SettingViewController()
        self.navigationController!.pushViewController(settingViewController, animated: true)
        
    }
    
    func testDidSelect() {
        let htmlURL = NSURL(string: "http://www.jianshu.com/p/" + "f69e8a5ae4f9")
        var webViewCtrl = WebViewController(url: htmlURL!)
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
        return displayData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("mainCell") as! UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mainCell")
        }
        cell.detailTextLabel!.text = "http://www.jianshu.com/p/" + displayData[indexPath.row]
        let filePath = contentFilePath + displayData[indexPath.row]
        let data = NSData(contentsOfFile: filePath)
        cell.textLabel!.text = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String!
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let htmlURL = NSURL(string: "http://www.jianshu.com/p/" + displayData[indexPath.row])
            var webViewCtrl = WebViewController(url: htmlURL!)
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
