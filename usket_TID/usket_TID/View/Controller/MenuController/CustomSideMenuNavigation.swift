//
//  CustomSideMenuNavigationController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/20.
//

import UIKit
import SideMenu

class CustomSideMenuNavigation: SideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //왼쪽 혹은 오른쪽 설정가능
        self.leftSide = true
        //width 설정 (50%)
        self.menuWidth = self.view.frame.width * 0.5
        //Animation Style
        self.presentationStyle = .viewSlideOutMenuPartialIn
        //보여지고 사라지는 속도
        self.presentDuration = 0.85
        self.dismissDuration = 0.85
    }
}
