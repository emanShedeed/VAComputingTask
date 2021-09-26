//
//  ComputingVC+TableViewDelegate.swift
//  VAComputingTask
//
//  Created by gody on 9/22/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit

extension ComputingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func setupTableView(){
        operatorAutoCombleteTV.dataSource = self
        operatorAutoCombleteTV.delegate = self
        resultTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.register(UINib(nibName: "OperatorResultTableViewCell", bundle: nil), forCellReuseIdentifier: "OperatorResultTableViewCell")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case resultTableView:
            return presenter.headerForSection.count
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case resultTableView:
           return  OpeartionTableViewHeader(headerTitle: presenter.headerForSection[section])
        default:
            return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case resultTableView:
            return 40
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case operatorAutoCombleteTV:
            return validOperators.count
        case resultTableView:
            switch section {
            case 0:
                return presenter.tobeComputedoperations.count
            case 1:
                return  presenter.computedOperations.count
            default:
                return 0
                
            }
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case resultTableView:
            return 90
        default:
            return 45
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case operatorAutoCombleteTV:
            var cell : UITableViewCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "autoCompleteCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "autoCompleteCell")
            }
            cell.textLabel?.text = validOperators[indexPath.row]
            cell.textLabel?.textAlignment = .center
            return cell
        case resultTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OperatorResultTableViewCell", for: indexPath) as! OperatorResultTableViewCell
            presenter.configureResultCell(cell: cell, at: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        operatorValidationLabel.isHidden=true
        operatorAutoCombleteTV.isHidden=true
        
        let  selectedName = validOperators[indexPath.row]
        operatorBtn.setTitle(selectedName, for: .normal)
        operatorBtn.tag = indexPath.row
        operatorBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
}
