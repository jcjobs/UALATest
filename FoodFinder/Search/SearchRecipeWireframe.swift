//
//  SearchRecipeWireframe.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit

class SearchRecipeWireframe: NSObject {
    private weak var navigation: UINavigationController?
    
    init(with sourceNavigation: UINavigationController?) {
        navigation = sourceNavigation
    }
    
    func showRecipeDetail(recipeId: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewControllerId") as? RecipeDetailViewController else { return }
        vc.recipeId = recipeId
        navigation?.pushViewController(vc, animated: true)
    }
}
