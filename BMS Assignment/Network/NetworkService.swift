//
//  NetworkService.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 08/01/23.
//

import Foundation


final class NetworkClient: NetworkService, URLRequestConvertible {
    //MARK: Properties
    private let session: URLSession
    
    static var currentSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 30
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    //MARK: Initializer
    init(session: URLSession = NetworkClient.currentSession) {
        self.session = session
    }
    
    //MARK: Methods
    func dataRequest<T>(_ endPoint: APIRequestModel, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask where T : Decodable {
        var request: URLRequest
        
        request = makeURLRequest(apiModel: endPoint)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                completion(Result.failure(NetworkError.unknown))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(Result.failure(NetworkError.incorrectData(data ?? Data())))
                return
            }
            
            self.printJSON(data: data)
            do {
                let jsonObject = try JSONDecoder().decode(objectType, from: data)
                completion(Result.success(jsonObject))
            } catch {
                completion(Result.failure(NetworkError.unknown))
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    func downloadDataWith(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        return dataTask
    }
    
}

extension NetworkClient {
    func printJSON(data: Data) {
        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = String.init(data: jsonData, encoding: .utf8)
        print(string ?? "")
    }
}
