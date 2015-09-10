//
//  main.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation
let contentFilePath = "/Users/hezitong/Projects/DSCurriculumDesign/codes/contents_/"
//let contentFilePath = NSBundle.mainBundle().bundlePath + "/093836216e2a"
let dicFileURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath + "/testDic")!
let contentFileURL = NSURL(fileURLWithPath: contentFilePath)!
let indexSavePath = "/Users/hezitong/Projects/DSCurriculumDesign/codes/indexSaveFile"
var dic = CWSDictionary()
var content = CWSContent()

