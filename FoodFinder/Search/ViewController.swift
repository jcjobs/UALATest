//
//  ViewController.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit

protocol SearchFoodDisplayLogic: BaseProtocolDisplay {
    func showRecipeResult(with result: [Recipe])
}

class ViewController: BaseViewController {
    
    @IBOutlet weak var srcMealSearchBar: UISearchBar!
    @IBOutlet weak var tblRecipeResult: UITableView!
    
    private var presenter: SearchRecipePresenterLogic?
    private var arrayRecipe = [Recipe]()
    
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
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        searchResultsFor()
    }

}
    
private extension ViewController {
    func setup() {
        presenter = SearchRecipePresenter(with: self)
    }
    
    func setupUI() {
        srcMealSearchBar.delegate = self
        
        tblRecipeResult.delegate = self
        tblRecipeResult.dataSource = self
    }
    
    func searchResultsFor() {
        guard let searchString = srcMealSearchBar.text else { return }
        presenter?.searchResultsFor(searchString: searchString)
    }
}

extension ViewController: SearchFoodDisplayLogic {
    func showRecipeResult(with result: [Recipe]) {
        arrayRecipe = result
        tblRecipeResult.reloadData()
    }
    
    func showErrorMessage(with message: String) {
        showAlert(with: message)
    }
    
    func showLoader() {
        startAnimating()
    }
    
    func hideLoader() {
        stopAnimating()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.text = nil
       searchBar.resignFirstResponder()
       tblRecipeResult.resignFirstResponder()
        tblRecipeResult.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResultsFor()
        searchBar.resignFirstResponder()
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchResultsFor()
            searchBar.resignFirstResponder()
        }
    }
    
}

//MARK:- TableView Protocols
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath as IndexPath) as! RecipeTableViewCell
        
        let item = arrayRecipe[indexPath.row]
      
        cell.accessoryType = .disclosureIndicator
        cell.setup(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrayRecipe[indexPath.row]
        presenter?.showRecipeDetail(with: selectedItem.id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
