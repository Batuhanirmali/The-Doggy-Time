//
//  RandomSuggestionViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 11.11.2022.
//

import UIKit

final class RandomSuggestionViewController: UIViewController {
    
    @IBOutlet weak var randomDogFemaleName: UILabel!
    @IBOutlet weak var randomDogMaleName: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var Btn: UIButton!

    let viewModel = DogImageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dogImage.layer.masksToBounds = true
        viewModel.imageURLUpdated = { [weak self] in
                    guard let imageURL = self?.viewModel.imageURL,
                        let url = URL(string: imageURL),
                        let imageData = try? Data(contentsOf: url) else {
                            return
                    }
                  DispatchQueue.main.sync {
                    self?.dogImage.image = UIImage(data: imageData)
                 }
                }
    }
    
    
    
    @IBAction func showRandomDogPressed(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.2,
        animations: {
        sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
        completion: { finish in
        UIButton.animate(withDuration: 0.2, animations: {
        sender.transform = CGAffineTransform.identity
        })
        })
        
        viewModel.fetchRandomDogImage()
        randomDogMaleName.text = male.randomElement()
        randomDogFemaleName.text = female.randomElement()
    }
    
}
