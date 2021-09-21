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
    var numbers:[Double]
    init(operation:OperationContainer,operationType:String, name:String,delayTime:Double,numbers:[Double]) {
        self.name = name
        self.operation = operation
        self.delayTime = delayTime
        self.numbers = numbers
        self.operationType = operationType
        performOperation()
    }
    func performOperation() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
          
            let result = self.operation.performOperation(numbers: self.numbers, type: self.operationType)
            print(result)
        }
        
    }
    
}
