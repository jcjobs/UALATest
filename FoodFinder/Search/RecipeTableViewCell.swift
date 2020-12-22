//
//  RecipeTableViewCell.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    static let identifier = "RecipeTableViewCellId"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imvImage: UIImageView!

    func setup(with item: Recipe){
        lblTitle.text = item.title
        lblTitle.adjustsFontSizeToFitWidth = true
        lblDescription.text = item.detail
        imvImage.image = nil
        if !item.urlImage.isEmpty, let _  = URL(string: item.urlImage) {
            imvImage.fromRemotePath(urlPath:  item.urlImage)
        }
    }

}
