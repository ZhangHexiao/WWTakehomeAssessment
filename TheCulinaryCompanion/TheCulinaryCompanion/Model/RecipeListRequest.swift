//
//  Request.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-13.
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
