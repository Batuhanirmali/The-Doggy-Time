//
//  OnboardingCollectionViewCell.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.11.2022.
//

import UIKit
// MARK: CollectionViewCell section.
class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)

    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitle.text = slide.title
        slideDescription.text = slide.description
    }
}

/*    override func viewDidLoad() {
super.viewDidLoad()

slides = [
    OnboardingSlide(title: "Breeds 🐶", description: "If you are wondering about the characteristics of dog breeds and breeds", image: #imageLiteral(resourceName: "onboardDog1")),
    OnboardingSlide(title: "Food 🦴", description: "Here you will find a list of fruits and vegetables that dogs can eat and their benefits.", image: #imageLiteral(resourceName: "onboardDog2")),
    OnboardingSlide(title: "Name 🐾", description: "If you want to name your dog, if you need advice, you are at the right place.", image: #imageLiteral(resourceName: "onboardDog3"))
]
}
*/
