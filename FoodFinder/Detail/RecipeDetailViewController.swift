//
//  RecipeDetailViewController.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit

protocol RecipeDetailDysplayLogic: BaseProtocolDisplay {
    func showDetailFor(recipe: Recipe)
}

class RecipeDetailViewController: BaseViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imvRecipeImage: UIImageView!
    @IBOutlet weak var tblRecipeDetail: UITableView!
    
    
    var recipeId:Int = 0
    private var recipeDetail: Recipe?
    private var presenter: RecipeDetailPresenterLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        getRecipeDetail()
    }


}

private extension RecipeDetailViewController {
    func setup() {
        presenter = RecipeDetailPresenter(with: self)
    }
    
    func setupUI() {
        tblRecipeDetail.dataSource = self
        tblRecipeDetail.delegate = self
    }
    
    func getRecipeDetail() {
        presenter?.getRecipeDetailWith(recipeId: recipeId)
    }
}

extension RecipeDetailViewController: RecipeDetailDysplayLogic {
    func showErrorMessage(with message: String) {
        showAlert(with: message)
    }
    
    func showLoader() {
        startAnimating()
    }
    
    func hideLoader() {
        stopAnimating()
    }
    
    func showDetailFor(recipe: Recipe) {
        recipeDetail = recipe
        lblName.text = recipeDetail?.title
        lblCategory.text = recipeDetail?.detail
        imvRecipeImage.image = nil
        if let imageRecipe = recipeDetail?.urlImage, !imageRecipe.isEmpty, let _  = URL(string: imageRecipe) {
            imvRecipeImage.fromRemotePath(urlPath: imageRecipe)
        }
        
        tblRecipeDetail.reloadData()
    }
}

//MARK:- TableView Protocols
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = recipeDetail?.ingredients[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if( !(cell != nil)) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }

        cell!.textLabel?.text = item
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
