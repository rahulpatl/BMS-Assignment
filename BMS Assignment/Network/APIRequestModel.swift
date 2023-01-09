//
//  APIRequestModel.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 07/01/23.
//

import Foundation
struct APIRequestModel: APIModelProtocol {
    var api: APIConfigurations
    var params: [String: Any]?

    init(api: APIConfigurations, parameters: [String: Any]? = nil) {
        self.api = api
        self.params = parameters
    }
}
