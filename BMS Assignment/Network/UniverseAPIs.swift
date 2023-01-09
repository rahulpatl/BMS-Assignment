//
//  UniverseAPIs.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 07/01/23.
//

import Foundation
enum UniverseAPIs {
    case getUniverses
}

extension UniverseAPIs: APIConfigurations {
    func getHTTPMethod() -> HTTPMethod {
        var methodType = HTTPMethod.GET
        switch self {
        case .getUniverses:
            methodType = .GET
        }
        return methodType
    }
    
    func getAPIPath() -> String {
        var endPoint = getAPIBasePath()
        switch self {
        case .getUniverses:
             endPoint += UniverseAPIConstants.universes
        }
        return endPoint
    }
    
    func getAPIBasePath() -> String {
        switch self {
        case .getUniverses:
             return UniverseAPIConstants.baseURL
        }
    }
    
    func getHeaders() -> [String: String] {
        var headerDict = [String: String]()
        headerDict["Content-Type"] = "application/json"
        return headerDict
    }
    
    
}
