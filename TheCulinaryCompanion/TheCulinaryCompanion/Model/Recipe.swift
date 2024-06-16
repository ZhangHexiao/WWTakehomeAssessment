//
//  RecipeModel.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-15.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let name: String
    let points: Int
    let preparationTime: Int
    let difficultyLevel: DifficultyLevel
    let images: [Image]
    
    var smallImage: Image? {
        return images.first { $0.imageType == ImageType.small }
       }
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, points, preparationTime, difficultyLevel, images

    }
}

struct Image: Decodable {
    let url: String
    let width: Int
    let height: Int
    let imageType: ImageType
}

enum DifficultyLevel: String, Codable {
    case easy = "EASY"
    case moderate = "MODERATE"
}

enum ImageType: String, Codable {
    case small = "SMALL"
    case medium = "MEDIUM"
    case large = "LARGE"
    case extraLarge = "EXTRALARGE"
    case square600 = "SQUARE600"
    case square200 = "SQUARE200"
}

