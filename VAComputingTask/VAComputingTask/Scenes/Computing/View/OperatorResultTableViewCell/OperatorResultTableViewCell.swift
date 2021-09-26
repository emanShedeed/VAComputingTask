//
//  OperatorResultTableViewCell.swift
//  VAComputingTask
//
//  Created by gody on 9/21/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit

class OperatorResultTableViewCell: UITableViewCell {
    @IBOutlet weak var operationNameLabel:UILabel!
    @IBOutlet weak var dealyTimeLabel:UILabel!
    @IBOutlet weak var remainingTimeLabel:UILabel!
    @IBOutlet weak var resultLabel:UILabel!
    var indexPath:IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
