//
//  ApiRequest.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-13.
//

import Foundation

public protocol APIRequest: Encodable {
    
    associatedtype Response: Decodable
    
    var resourceName: String { get }
}
