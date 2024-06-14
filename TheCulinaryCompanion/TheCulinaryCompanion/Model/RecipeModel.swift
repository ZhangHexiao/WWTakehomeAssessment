//
//  RecipeModel.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-14.
//

import Foundation

struct RecipeModel: Decodable {
    let id: String
    let name: String
    let points: Int
    let preparationTime: Int
    let difficultyLevel: String
//  let image: Image

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, points, preparationTime, difficultyLevel
//      image,
    }
}
