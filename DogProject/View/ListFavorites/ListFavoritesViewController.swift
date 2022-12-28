//
//  ListFavoritesViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 29.11.2022.
//

protocol ListFavoritesViewControllerInterface: AnyObject {
    func prepareView()
    func register()
}

import UIKit
import ProgressHUD

final class ListFavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = ListFavoritesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        bindViewModel()
        fetchpresenter()
    }
    
    //override func viewDidAppear(_ animated: Bool) {
    //    viewModel.viewDidAppear()
    //}
    
    private func registerCells() {
        viewModel.registerCells()
    }
    private func fetchpresenter(){
        ProgressHUD.show()
        viewModel.fetchpresenter()
    }
    
    private func bindViewModel() {
        viewModel.fetchFavoritesSucceeded = { [weak self] favorites in
            ProgressHUD.dismiss()
            self?.viewModel.favorites = favorites
            self?.tableView.reloadData()
        }
        
        viewModel.fetchFavoritesFailed = { [weak self] errorMessage in
        ProgressHUD.showError(errorMessage)
        }
    }

}

// MARK: TableViewDelegate and TableViewDataSource

extension ListFavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogListTableViewCell.identifier) as!
        DogListTableViewCell
        cell.setup(favorite: viewModel.favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = FavoriteDetailViewController.instantiate()
        controller.breed = viewModel.favorites[indexPath.row].breed
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            viewModel.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.endUpdates()
        }
    }
}

// MARK: VC - Interface

extension ListFavoritesViewController: ListFavoritesViewControllerInterface {
    
    func prepareView() {
        registerCells()
    }
    
    func register() {
        tableView.register(UINib(nibName: DogListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DogListTableViewCell.identifier)
    }
    
    
}
