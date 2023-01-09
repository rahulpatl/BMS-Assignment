//
//  DownloadOperation.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 09/01/23.
//

import UIKit

class DownloadOperation : Operation {
    
    private var task : URLSessionDataTask!
    
    enum OperationState : Int {
        case ready
        case executing
        case finished
    }
    
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
    
    init(session: NetworkService, downloadTaskURL: URL, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
        super.init()
        task = session.downloadDataWith(url: downloadTaskURL, completion: { [weak self] (data, response, error) in
            if let completionHandler = completionHandler {
                completionHandler(data, response, error)
            }
            
            self?.state = .finished
        })
    }
    
    override func start() {
        if(self.isCancelled) {
            state = .finished
            return
        }
        
        state = .executing
        
        print("downloading \(self.task.originalRequest?.url?.absoluteString ?? "")")
            self.task.resume()
    }
    
    override func cancel() {
        super.cancel()
        self.task.cancel()
    }
}
