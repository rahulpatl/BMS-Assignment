//
//  NetworkServiceProtocols.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 07/01/23.
//

import Foundation

/// Contains necessary methods to generate `URLRequest`
protocol APIConfigurations {
    func getHTTPMethod() -> HTTPMethod
    func getAPIPath() -> String
    func getAPIBasePath() -> String
    func getHeaders() -> [String: String]
}

protocol NetworkService {
    @discardableResult func dataRequest<T: Decodable>(_ endPoint: APIRequestModel, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask
    @discardableResult func downloadDataWith(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

protocol APIModelProtocol {
    var api: APIConfigurations { get set }
    
    /// Post request body parameters
    var params: [String: Any]? { get set }
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

enum UniverseAPIConstants {
    static var baseURL = "https://run.mocky.io"
    static var universes = "/v3/3949f9a5-0f8b-4d96-a935-e5e1b46f2296"
}

enum NetworkError: Swift.Error {
    case incorrectData(Data)
    case incorrectURL
    case unknown
}
