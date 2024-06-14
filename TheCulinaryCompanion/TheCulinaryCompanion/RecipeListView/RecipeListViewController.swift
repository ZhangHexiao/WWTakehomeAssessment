//
//  RecipeListScreen.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-13.
//

import Foundation
import UIKit

class RecipeListViewController:  UIViewController{
    
    override func viewDidLoad() {
        print("nihao")
        RecipeService(networkManager: NetworkManager()).getPaginateRecipe(page: 1){result in
            print(result)
        }
    }
    
}
