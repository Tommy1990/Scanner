//
//  File.swift
//  CodeScanner
//
//  Created by yong fu on 2019/2/27.
//  Copyright © 2019 com.nongfaziran.nfzr. All rights reserved.
//

import Foundation
import UIKit

//状态栏高度
let STATUS_BAR_HEIGHT: CGFloat      = IS_IPHONE_XSERIOUS  ? 44 : 20
//NavBar高度
let NAVIGATION_BAR_HEIGHT: CGFloat  = 44
//TabBar高度
let TAB_BAR_HEIGHT: CGFloat         = IS_IPHONE_XSERIOUS ? 88:49
//状态栏 ＋ 导航栏 高度
let STATUS_AND_NAVIGATION_HEIGHT = STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT

//IphoneX底部遗留高度
let IPHONE_X_OFFSET:CGFloat = IS_IPHONE_XSERIOUS ? 39:0

//屏幕 rect
let SCREEN_RECT = UIScreen.main.bounds
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let CONTENT_HEIGHT = SCREEN_HEIGHT - STATUS_AND_NAVIGATION_HEIGHT
let CONTENT_REDTABBAR_HEIGHT = SCREEN_HEIGHT - STATUS_AND_NAVIGATION_HEIGHT - TAB_BAR_HEIGHT

//请求条数
let NUMBER_LIMIT = 10

let IS_IPHONE_4 = UIDevice.getCurrentPhoneStyle() == SMALLPHONE ? 1 : 0

let IS_IPHONE_5 = UIDevice.getCurrentPhoneStyle() == IPHONESE_5_5S ? 1 : 0

let IS_IPHONE_6Or7 = UIDevice.getCurrentPhoneStyle() == IPHONE6_6S_7_8 ? 1 : 0

let IS_IPHONE_6OR7_PLUS = UIDevice.getCurrentPhoneStyle() == IPHONE6P_6SP_7P_8P ? 1 : 0

let IS_IPHONE_XrXS = UIDevice.getCurrentPhoneStyle() == IPHONEX_XS ? 1 : 0

let IS_IPHONE_X_MAX = UIDevice.getCurrentPhoneStyle() == IPHONEXMAX ? 1 : 0

let IS_IPHONE_XR = UIDevice.getCurrentPhoneStyle() == IPHONEXR ? 1 : 0
let IS_IPHONE_XSERIOUS = (IS_IPHONE_XrXS == 1) || (IS_IPHONE_X_MAX == 1) || (IS_IPHONE_XR == 1)
