//
//  RecipeDetailViewController.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit

protocol RecipeDetailDysplayLogic {
    func showDetailFor(recipe: Recipe)
}

class RecipeDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

extension RecipeDetailViewController: RecipeDetailDysplayLogic {
    func showDetailFor(recipe: Recipe) {
        
    }
}
