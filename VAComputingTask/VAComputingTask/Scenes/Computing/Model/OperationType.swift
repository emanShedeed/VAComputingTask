//
//  OperationType.swift
//  VAComputingTask
//
//  Created by gody on 9/20/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit
protocol OperationHnadlerProtocol {
    var operationType:String { get set }
    func performOperation(numbers:[Double])->Double
}
class OperationContainer{
    var operationHandlers:[String:OperationHnadlerProtocol] = [:]
    init(operations:[OperationHnadlerProtocol]) {
        operations.forEach { operation in
            operationHandlers[operation.operationType] = operation
        }
    }
    func performOperation(numbers:[Double],type:String)->Double {
        guard let operationHandler = operationHandlers[type] else { return 0 }
        return operationHandler.performOperation(numbers: numbers)
        
    }
}

struct Plus:OperationHnadlerProtocol {
    var operationType = "+"
    func performOperation(numbers:[Double]) -> Double {
        numbers.reduce(0) { $0 + $1 }
    }
}
struct Minus:OperationHnadlerProtocol {
    var operationType = "-"
    func performOperation(numbers:[Double]) -> Double {
        var array = numbers
       array[0] = array[0] * -1
        return array.reduce(0) { $0 - $1 }
        
    }
}
struct Multiplication :OperationHnadlerProtocol {
    var operationType = "*"
 func performOperation(numbers:[Double]) -> Double {
        numbers.reduce(1) { $0 * $1 }
    }
    
    
}
struct Division :OperationHnadlerProtocol {
    var operationType = "/"
    
    func performOperation(numbers:[Double]) -> Double {
        var array = numbers
        array[0] = 1/array[0]
        return array.reduce(1) { $0 / $1 }
    }
}
