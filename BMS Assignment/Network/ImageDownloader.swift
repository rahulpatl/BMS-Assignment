//
//  ImageDownloader.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 09/01/23.
//

import UIKit

let imagesCache = NSCache<NSString, AnyObject>()
class ImageDownloader {
    var queue : OperationQueue!
    var session : NetworkService!
    var operation: Operation?

    init(queue: OperationQueue = OperationQueue(), session: NetworkService = NetworkClient()) {
        self.session = session
        self.queue = queue
        queue.maxConcurrentOperationCount = 4
    }
    
    func startDownload(with url: URL, handler: @escaping (UIImage?, Error?) -> Void) {
        if let _image = imagesCache.object(forKey: NSString(string: url.absoluteString)) as? UIImage {
            handler(_image, nil)
            return
        }
        
        operation = DownloadOperation(session: self.session, downloadTaskURL: url, completionHandler: { (_data, urlResponse, error) in
            if error == nil {
                if let data = _data, let image = UIImage(data: data) {
                    imagesCache.setObject(image, forKey: url.absoluteString as NSString)
                    handler(image, error)
                } else {
                    handler(nil, error)
                }
            }
        })
        
        if let operation = self.operation {
            self.queue.addOperation(operation)
        }
    }
    
    func cancelDownload() {
        operation?.cancel()
    }
}
