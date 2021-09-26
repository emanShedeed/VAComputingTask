//
//  AutomaticHeightTableView.swift
//  VAComputingTask
//
//  Created by gody on 9/21/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit
class FullHeightTableView:UITableView{
    var contentSizeChanged: ((CGFloat) -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentSizeChanged?(self.contentSize.height)
    }
}
