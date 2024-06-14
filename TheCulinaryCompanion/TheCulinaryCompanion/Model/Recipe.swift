//
//  RecipeModel.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-14.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let name: String
    let points: Int
    let preparationTime: Int
    let difficultyLevel: DifficultyLevel
//  let image: Image
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, points, preparationTime, difficultyLevel
//      image,
    }
}

enum DifficultyLevel: String, Codable {
    case easy = "EASY"
    case moderate = "MODERATE"
}

