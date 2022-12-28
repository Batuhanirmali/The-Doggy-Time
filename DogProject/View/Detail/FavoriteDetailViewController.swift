//
//  FavoriteDetailViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 26.11.2022.
//

import UIKit
import ProgressHUD

class FavoriteDetailViewController: UIViewController, FavoriteDetailVMOutput {
    func showProgress(isShow: Bool) {
        ProgressHUD.showSuccess("The name you chose has been saved")
    }
    
    
   @IBOutlet weak var shortdescriptionLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    var breed: Breed!
    var viewModel: FavoriteDetailVM = FavoriteDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
        viewModel.delegate = self
    }
    
    private func populateView() {
        favoriteImageView.kf.setImage(with: breed.image?.asUrl)
        favoriteTitleLabel.text = breed.name
        descriptionLabel.text = breed.description
        shortdescriptionLabel.text = breed.shortDescription
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.green.cgColor
           colorAnimation.duration = 1  // animation duration
           // colorAnimation.autoreverses = true // optional in my case
           // colorAnimation.repeatCount = FLT_MAX // optional in my case
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty else {
            
            let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
            colorAnimation.fromValue = UIColor.red.cgColor
            colorAnimation.duration = 1  // animation duration
               // colorAnimation.autoreverses = true // optional in my case
               // colorAnimation.repeatCount = FLT_MAX // optional in my case
            sender.layer.add(colorAnimation, forKey: "ColorPulse")
            
            ProgressHUD.showError("Please enter your name")
            return
        }
        
        viewModel.addFavoriteDogName(dogId: breed.id ?? "", name: name)
        //ProgressHUD.show("Name is registiring")
    }

}
