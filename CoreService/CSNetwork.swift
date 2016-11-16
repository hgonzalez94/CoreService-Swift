//
//  CSNetwork.swift
//  CoreService
//
//  Created by Hugo Gonzalez on 11/14/16.
//  Copyright © 2016 Cat Bakery. All rights reserved.
//

import Foundation

open class CSNetwork {
    // MARK: - Public Properties
    
    /// Singleton primary instance
    open static let main = CSNetwork()
    
    /// Base url endpoint for all requests. Read-Only.
    public var baseURL: String {
        return baseURLString
    }
    
    // MARK: - Private Properties
    
    private var baseURLString = ""
    
    // MARK: - Public Functions
    
    open func setupNetwork(urlString: String, port: String = "80") {
        baseURLString = urlString
    }
}
