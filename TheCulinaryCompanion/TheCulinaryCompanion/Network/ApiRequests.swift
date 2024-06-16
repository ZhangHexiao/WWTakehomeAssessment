//
//  Request.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-15.
//

import Foundation

struct RecipeListRequest: APIRequest {
    let urlPath = "/list"
    let method = HTTPMethod.get
    let page: Int
    init(page: Int) {
        self.page = page
    }
    var parameters: [String: String]? {
        return ["page": String(page)]
    }
}

struct ImageDownLoadRequest: APIRequest {
    var baseURL: String = ""
    var urlPath: String
    let method = HTTPMethod.get
    let parameters: [String : String]? = nil
    init(url: String) {
        self.urlPath = url
    }
}
