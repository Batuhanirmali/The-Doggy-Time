//
//  ListDogsViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 29.11.2022.
//

import UIKit
import ProgressHUD

class ListDogsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListDogsVM!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = viewModel.category.name
            registerCells()
            ProgressHUD.show()
            viewModel.fetchCategoryDogs { [weak self] result in
                ProgressHUD.dismiss()
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
                }
            }
        }
        
        private func registerCells() {
            tableView.register(UINib(nibName: DogListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DogListTableViewCell.identifier)
        }
    }

    extension ListDogsViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.dogs.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: DogListTableViewCell.identifier) as! DogListTableViewCell
            cell.setup(breed: viewModel.dogs[indexPath.row])
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let controller = FavoriteDetailViewController.instantiate()
            controller.breed = viewModel.dogs[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
