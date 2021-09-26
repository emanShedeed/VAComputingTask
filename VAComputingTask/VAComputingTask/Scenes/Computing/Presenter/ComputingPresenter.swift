//
//  ComputingPresenter.swift
//  VAComputingTask
//
//  Created by gody on 9/20/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import Foundation
protocol ComputingProtocol :class{
    //    func reloadCellAt(indexPath:IndexPath)
    func reloadResultTVData()
}
class ComputingPresenter:TimerProtocol{
    private weak var view : ComputingProtocol?
    var tobeComputedoperations:[Operation] = []
    var computedOperations:[Operation] = []
    var headerForSection: [String] = ["Queued Operations", "Claculated Operations"]
    init(view:ComputingProtocol) {
        self.view=view
    }
    func performOperation(obj:Operation) {
        tobeComputedoperations.append(obj)
        view?.reloadResultTVData()
        let timerobj = CountDownTimer(obj: obj, view: self)
        timerobj.delegate = self
        timerobj.startTimer()
        DispatchQueue.global().asyncAfter(deadline: .now() + obj.delayTime) { [weak self] in
            guard let self = self else { return}
            let result = obj.operation.performOperation(numbers: obj.numbers, type: obj.operationType)
            DispatchQueue.main.async { [weak self ] in
                self?.manageOperation(obj: obj)
                self?.view?.reloadResultTVData()
            }
            
            obj.result = Double((String(format:"%.4f", result))) ?? 0.0
            print("result for operation: \(obj.name) = \(result)")
        }
        
    }
    
    private func manageOperation(obj:Operation)  {
        computedOperations.append(obj)
        let index = tobeComputedoperations.firstIndex(where:{$0.name == obj.name})
        guard  let id = index else { return }
        tobeComputedoperations.remove(at: id)
    }
    
    func configureResultCell(cell:OperatorResultTableViewCell, at indexPath:IndexPath){
        cell.indexPath = indexPath
        switch indexPath.section {
        case 0:
            cell.operationNameLabel.text = tobeComputedoperations[indexPath.row].name
            cell.resultLabel.text = "Not Yet"
            cell.dealyTimeLabel.text = "\(tobeComputedoperations[indexPath.row].delayTime)"
            cell.remainingTimeLabel.text = "\(tobeComputedoperations[indexPath.row].remainingTime)"
        default:
            cell.operationNameLabel.text = " \(computedOperations[indexPath.row].name)"
            cell.resultLabel.text = "\(computedOperations[indexPath.row].result)"
            cell.dealyTimeLabel.text = "\(computedOperations[indexPath.row].delayTime)"
            cell.remainingTimeLabel.text = "0"
        }
    }
    func updateCell(OfObject object:Operation){
        //        let index = tobeComputedoperations.firstIndex(where: {$0.name == object.name})
        //        guard let cellIndex = index else {return}
        //        view?.reloadCellAt(indexPath: IndexPath(row: cellIndex, section: 0))
        view?.reloadResultTVData()
        
    }
}
protocol TimerProtocol {
    func updateCell(OfObject:Operation)
}
class CountDownTimer {
    var object:Operation
    var timeLeft:Int
    var timer:Timer?
    var delegate:TimerProtocol?
    init(obj:Operation,view:TimerProtocol){
        self.object = obj
        self.timeLeft = Int(obj.delayTime)
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown() {
        if timeLeft > 0 {
            object.remainingTime = Double(timeLeft)
            delegate?.updateCell(OfObject: object)
            timeLeft -= 1
            print(timeLeft)
        } else {
            // Timer stopping
            timer?.invalidate()
        }
    }
}
