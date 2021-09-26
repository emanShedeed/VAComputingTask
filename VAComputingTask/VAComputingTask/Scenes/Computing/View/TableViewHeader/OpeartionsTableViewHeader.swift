//
//  OpeartionsTableViewHeader.swift
//  VAComputingTask
//
//  Created by gody on 9/22/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit
class OpeartionTableViewHeader: UITableViewHeaderFooterView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    init(headerTitle: String) {
        super.init(reuseIdentifier: String(describing: OpeartionTableViewHeader.self))
        configure(text: headerTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text:String) {
        titleLabel.text = text
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor.appColor!
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 50.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
}
