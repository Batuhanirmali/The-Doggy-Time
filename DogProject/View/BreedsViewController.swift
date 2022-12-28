//
//  BreedsViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 11.11.2022.
//

import UIKit
import ProgressHUD

protocol BreedsViewControllerInterface: AnyObject {
    func prepareCollectionView()
    func registercell()
}

protocol BreedsPresenterDelegate: AnyObject {
    func fetchCategoriesSucceeded(_ categories: [DogCategory], _ populars: [Breed], _ downCategories: [Breed])
    func fetchCategoriesFailed(_ errorMessage: String)
}

final class BreedsViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    // main storyboard collection View adding (dataSource, delegate)
    @IBOutlet weak var popularCollectionView: UICollectionView!
    // main storyboard collection View adding (dataSource, delegate)
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    // main storyboard collection View adding (dataSource, delegate)
    
    private lazy var viewModel = BreedsVM()
    var presenter = BreedsPresenter()
    
    // data, move mvvm
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        fetchCategories()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    private func registerCell() {
        viewModel.registercell()
    }
    
    private func fetchCategories(){
            ProgressHUD.show()
        presenter.fetchCategories()
    }
    private func bindViewModel() {
            viewModel.fetchCategoriesSucceeded = { [weak self] categories, populars, downCategories in
                ProgressHUD.dismiss()
                self?.viewModel.categories = categories
                self?.viewModel.populars = populars
                self?.viewModel.downCategories = downCategories
                self?.categoryCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                self?.specialsCollectionView.reloadData()
    }
        viewModel.fetchCategoriesFailed = { [weak self] errorMessage in
           ProgressHUD.showError(errorMessage)
            }
    }
    
    
}

extension BreedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return viewModel.categories.count
        case popularCollectionView:
            return viewModel.populars.count
        case specialsCollectionView:
            return viewModel.downCategories.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            
            cell.setup(category: viewModel.categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogPortraitCollectionViewCell.identifier, for: indexPath) as! DogPortraitCollectionViewCell
            cell.setup(breed: viewModel.populars[indexPath.row])
            return cell
            
        case specialsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogLandscapeCollectionViewCell.identifier, for: indexPath) as! DogLandscapeCollectionViewCell
            
            cell.setup(breed: viewModel.downCategories[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == categoryCollectionView {
                let viewModel = ListDogsVM(category: viewModel.categories[indexPath.row])
                let controller = ListDogsViewController.instantiate()
                controller.viewModel = viewModel
                navigationController?.pushViewController(controller, animated: true)
            } else {
                let controller = FavoriteDetailViewController.instantiate()
                controller.breed = collectionView == popularCollectionView ? viewModel.populars[indexPath.row] : viewModel.downCategories[indexPath.row]
                navigationController?.pushViewController(controller, animated: true)
            }
        }
}


extension BreedsViewController: BreedsViewControllerInterface {
    internal func registercell() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        popularCollectionView.register(UINib(nibName: DogPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DogPortraitCollectionViewCell.identifier)
        
        specialsCollectionView.register(UINib(nibName: DogLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DogLandscapeCollectionViewCell.identifier)
    }
    
    func prepareCollectionView() {
        registerCell()
    }
    
}

extension BreedsViewController: BreedsPresenterDelegate {
    func fetchCategoriesSucceeded(_ categories: [DogCategory], _ populars: [Breed], _ downCategories: [Breed]) {
    ProgressHUD.dismiss()
        self.viewModel.categories = categories
        self.viewModel.populars = populars
        self.viewModel.downCategories = downCategories
        self.categoryCollectionView.reloadData()
        self.popularCollectionView.reloadData()
        self.specialsCollectionView.reloadData()
    }

    func fetchCategoriesFailed(_ errorMessage: String) {
        ProgressHUD.showError(errorMessage)
    }
}
