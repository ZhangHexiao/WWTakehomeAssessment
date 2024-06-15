//
//  RecipeListScreen.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-13.
//

import Foundation
import UIKit

class RecipeListViewController:  UIViewController{
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecipeViewCell.self, forCellReuseIdentifier: RecipeViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    var viewModel: RecipeListViewModel = RecipeListViewModel(recipeService: RecipeService())
    
    override func viewDidLoad() {
        view.backgroundColor = .secondarySystemBackground
        setUpTitle()
        setUpTableView()
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    func setUpTitle(){
        navigationItem.title = "The Culinary Companion"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = .white
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        
    }
    
    func setUpTableView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        tableView.dataSource = self
        tableView.delegate = self
        spinner.hidesWhenStopped = true
        tableView.separatorStyle = .none
        tableView.tableFooterView = spinner
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if(viewModel.isLoading){
                spinner.startAnimating()
            }
            viewModel.fetchData()
        }
    }
}

extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeViewCell.identifier, for: indexPath) as? RecipeViewCell ?? RecipeViewCell()
        cell.configCell(recipt: viewModel.recipeList[indexPath.row])
        return cell
    }
    
}

extension RecipeListViewController: RecipeListViewModelDelegate{
    func viewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
        print("data reloaded")
    }
}
