//
//  UIView+Extension.swift
//  VAComputingTask
//
//  Created by gody on 9/21/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit
@IBDesignable
extension UIView {
  

    func addBorderWith(borderColor:UIColor, borderWith:CGFloat, borderCornerRadius:CGFloat) {
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = borderCornerRadius
        clipsToBounds = true

    }
  
}

