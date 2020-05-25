//
//  AsyncOperation.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 24.05.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation

class AsyncOperation: Operation{
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String{
            return "is" + rawValue.capitalized
        }
    }
    
    
    var state = State.ready{
        willSet{
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet{
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    override var isAsynchronous: Bool{
        return true
    }
    
    override var isReady: Bool{
        return super.isReady && state == .ready
    }
    
    override var isFinished: Bool{
        return state == .finished
    }
    
    override var isExecuting: Bool{
        return state == .executing
    }
    
    override func start() {
        if isCancelled{
            state = .finished
        }else{
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}
