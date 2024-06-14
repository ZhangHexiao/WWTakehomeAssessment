//
//  GetPaginateRecipeListService.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-14.
//

import Foundation

protocol RecipeServiceProtocol {
    func getPaginateRecipe(page: Int, completion: @escaping (Result<[Recipe], Error>) -> ())
}

class RecipeService: RecipeServiceProtocol{
    
    private let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getPaginateRecipe(page: Int, completion: @escaping (Result<[Recipe], Error>) -> ()) {
        let recipeListRequest = RecipeListRequest(page: page)
        NetworkManager.shared.executeRequest(apiRequest: recipeListRequest){ result in
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                decoder.userInfo[.context] = DecoderContext(itemsKey: "recipes")
                do {
                let pageWrapper = try decoder.decode(PageWrapper<Recipe>.self, from: response)
                    completion(.success(pageWrapper.items))
                } catch {
                    completion(.failure(NetworkError.jsonSerializationError))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}
