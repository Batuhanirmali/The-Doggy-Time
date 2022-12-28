//
//  DogPortraitCollectionViewCell.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 25.11.2022.
//

import UIKit

class DogPortraitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DogPortraitCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogShortDescription: UILabel!
    @IBOutlet weak var dogBigDescription: UILabel!
    
    func setup(breed: Breed) {
        titleLabel.text = breed.name
        dogImageView.kf.setImage(with: breed.image?.asUrl)
        dogShortDescription.text = breed.shortDescription
        dogBigDescription.text = breed.description
    }
    
    
}
