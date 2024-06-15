//
//  RecipeListViewModel.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-14.
//

import Foundation

protocol RecipeListViewModelDelegate: AnyObject {
    func viewReload()
}


class RecipeListViewModel {
    
    var recipeList:[Recipe] = []
    private var recipeService: RecipeServiceProtocol
    private var currentPage: Int = 0
    
    var isLoading = false
    
    weak var delegate: RecipeListViewModelDelegate?
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    func fetchData() {
        if isLoading {
            return
        }
        isLoading = true
        currentPage += 1
        recipeService.getPaginateRecipe(page: currentPage){
            result in
            print(result)
            switch result{
            case .success(let result):
                self.recipeList += result
                self.delegate?.viewReload()
                self.isLoading = false
            case .failure(let error):
                self.isLoading = false
                print(error)
            }
        }
    }
}
