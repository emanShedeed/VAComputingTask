//
//  Operation.swift
//  VAComputingTask
//
//  Created by gody on 9/20/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import Foundation
import UIKit

class Operation{
    var name: String
    let operation: OperationContainer
    let operationType: String
    var delayTime:Double
    var remainingTime:Double
    var numbers:[Double]
    var result:Double
    init(operation:OperationContainer,operationType:String, name:String,delayTime:Double,numbers:[Double]) {
        self.name = name
        self.operation = operation
        self.delayTime = delayTime
        self.remainingTime = delayTime
        self.numbers = numbers
        self.result = 0.0
        self.operationType = operationType
//        performOperation()
    }
  
}
