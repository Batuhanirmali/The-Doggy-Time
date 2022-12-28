//
//  DogListTableViewCell.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 29.11.2022.
//

import UIKit

class DogListTableViewCell: UITableViewCell {
    
    static let identifier = "DogListTableViewCell"
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(breed: Breed) {
        dogImageView.kf.setImage(with: breed.image?.asUrl)
        titleLabel.text = breed.name
        descriptionLabel.text = breed.description
    }
    
    func setup(favorite: Favorite)  {
        dogImageView.kf.setImage(with: favorite.breed?.image?.asUrl)
        titleLabel.text = favorite.breed?.name
        descriptionLabel.text = favorite.name
    }
    
}
