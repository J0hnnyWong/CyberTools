//
//  JNWNumerationTranferViewModel.swift
//  CyberTools
//
//  Created by John on 2021/3/23.
//

import UIKit
import RxCocoa
import RxSwift

class JNWNumerationTranferViewModel {
    
    var transforOperation: JNWNumerationTranforOperation?
    lazy var transforOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
        return queue
    }()
    
    var fromTypeDidSet: [((numeration) -> ())?] = []
    var toTypeDidSet: [((numeration) -> ())?] = []
    var toNumStrDidSet: [((String?) -> ())?] = []
    
    var fromType: numeration = .binary {
        didSet {
            fromTypeDidSet.forEach({ $0?(fromType) })
        }
    }
    
    var toType: numeration = .decimal {
        didSet {
            toTypeDidSet.forEach({ $0?(toType) })
        }
    }
    
    var fromNumStr: String? {
        didSet {
            transfor()
        }
    }
    
    var toNumStr: String? {
        didSet {
            toNumStrDidSet.forEach({ $0?(toNumStr) })
        }
    }
    
    func transfor() {
        
        guard
            let fromNumStrTmp = fromNumStr
        else {
            return
        }
        
        transforOperation?.cancel()
        transforOperation = JNWNumerationTranforOperation(value: fromNumStrTmp, from: fromType, to: toType)
        transforOperation?.completionBlock = { [weak self, weak transforOperation] in
            guard let sself = self else { return }
            DispatchQueue.main.async {
                sself.toNumStr = transforOperation?.result
            }
        }
        if let transforOperationTmp = transforOperation {
            transforOperationQueue.addOperation(transforOperationTmp)
        }
        
//        let result =  NumerationTranfer.transfer(value: fromNumStrTmp, from: fromType, to: toType)
//        toNumStr = result
    }
    
}


@propertyWrapper struct ddd<T> {
    
    var value: T?
    
    var wrappedValue: T? {
        get {
            return value
        }
        set {
            value = newValue
            projectedValue?()
        }
    }
    
    var projectedValue: (() -> ())?
    
    
    
}

class JNWNumerationTranforOperation: Operation {
    
    var value: String
    var fromType: numeration
    var toType: numeration
    var result: String = ""
    
    init(value: String, from: numeration, to: numeration) {
        self.value = value
        self.fromType = from
        self.toType = to
    }
    
    override func main() {
        result = NumerationTranfer.transfer(value: value, from: fromType, to: toType)
        completionBlock?()
    }
}
