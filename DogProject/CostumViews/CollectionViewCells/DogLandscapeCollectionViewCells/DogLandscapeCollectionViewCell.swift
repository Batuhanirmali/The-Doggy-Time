//
//  DogLandscapeCollectionViewCell.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 25.11.2022.
//

import UIKit

class DogLandscapeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: DogLandscapeCollectionViewCell.self)
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shortdescriptionLabel: UILabel!
    
    func setup(breed: Breed) {
        dogImageView.kf.setImage(with: breed.image?.asUrl)
        titleLabel.text = breed.name
        descriptionLabel.text = breed.description
        shortdescriptionLabel.text = breed.shortDescription
    }
}
