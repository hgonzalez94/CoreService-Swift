//
//  CSRouter.swift
//  CoreService
//
//  Created by Hugo Gonzalez on 11/15/16.
//  Copyright © 2016 Cat Bakery. All rights reserved.
//

import Foundation

enum CSRestRouter: URLRequestConvertible {
    case createNetworkObject(networkConfig: CSNetworkConfig, networkObject: CSNetworkObject, parameters: Parameters)
    case readNetworkObject(networkConfig: CSNetworkConfig, networkObject: CSNetworkObject)
    case updateNetworkObject(networkConfig: CSNetworkConfig, networkObject: CSNetworkObject, parameters: Parameters)
    case destroyNetworkObject(networkConfig: CSNetworkConfig, networkObject: CSNetworkObject)
    
    var method: HTTPMethod {
        switch self {
        case .createNetworkObject:
            return .post
        case .readNetworkObject:
            return .get
        case .updateNetworkObject:
            return .put
        case .destroyNetworkObject:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .createNetworkObject(_, let networkObject, _):
            return networkObject.path
        case .readNetworkObject(_, let networkObject):
            return networkObject.resourcePath()
        case .updateNetworkObject(_, let networkObject, _):
            return networkObject.resourcePath()
        case .destroyNetworkObject(_, let networkObject):
            return networkObject.resourcePath()
        }
    }
    
    var config: CSNetworkConfig {
        switch self {
        case .createNetworkObject(let networkConfig, _, _):
            return networkConfig
        case .readNetworkObject(let networkConfig, _):
            return networkConfig
        case .updateNetworkObject(let networkConfig, _, _):
            return networkConfig
        case .destroyNetworkObject(let networkConfig, _):
            return networkConfig
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let networkUrl = try config.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: networkUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createNetworkObject(_, _, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .updateNetworkObject(_, _, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
    }
}
