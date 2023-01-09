//
//  NetworkHelper.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 07/01/23.
//

import Foundation

protocol URLRequestConvertible {
    func makeURLRequest(apiModel: APIRequestModel) -> URLRequest
}
extension URLRequestConvertible {
    
    /// The method accepts `APIRequestModel` as an argument and generates `URLRequest`
    /// - Parameter apiModel: APIRequestModel
    /// - Returns: URLRequest
    func makeURLRequest(apiModel: APIRequestModel) -> URLRequest {
        let escapedAddress = apiModel.api.getAPIPath().addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        request.httpMethod = apiModel.api.getHTTPMethod().rawValue
        request.allHTTPHeaderFields = apiModel.api.getHeaders()

       if let params = apiModel.params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        return request
    }

}
