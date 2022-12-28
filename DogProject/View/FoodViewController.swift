//
//  FoodViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 11.11.2022.
//

import UIKit

class FoodViewController: UIViewController {

    @IBOutlet weak var FoodView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: FoodVM!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Initialize the view model
        viewModel = FoodVM(dogfoods: dogfoods, nameArray: nameArray, descriptionArray: descriptionArray,filteredData: dogfoods)
            
        FoodView.delegate = self
        FoodView.dataSource = self
        searchBar.delegate = self
        // filteredData = dogfoods
            // not tapped no see
            //FoodView.allowsSelection = false
        }
    }

extension FoodViewController: UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            vc.titleBig = viewModel.nameArray[indexPath.row]
            vc.getDescription = viewModel.descriptionArray[indexPath.row]
            vc.imgBig = UIImage(named: viewModel.filteredData[indexPath.row])!
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FoodView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let dogfood = viewModel.filteredData[indexPath.row]
        cell.foodImageView.image = UIImage(named: dogfood)
        cell.nameLabel.text = dogfood
        
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredData = []
        
        if searchText == "" {
            viewModel.filteredData = dogfoods
        } else {
            for foods in dogfoods {
                if foods.lowercased().contains(searchText.lowercased()) {
                    viewModel.filteredData.append(foods)
                }
            }
        }
        self.FoodView.reloadData()
    }
    
}


