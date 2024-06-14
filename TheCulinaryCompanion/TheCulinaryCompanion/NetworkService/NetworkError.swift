//
//  NetworkError.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-13.
//

import Foundation

public enum NetworkError: String, LocalizedError {
    
    case invalidData = "Response from the server is not valid, data was nil or zero length."
    case errorFromResponse = "Your request could not be processed."
    case invalidStatusCode = "Your request could not be processed, invalid statusCode"
    case jsonSerializationError = "Data format is wrong"
}
