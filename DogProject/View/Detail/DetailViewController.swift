//
//  DetailViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 17.11.2022.
//

import Foundation
import UIKit

protocol DetailViewControllerInterface: AnyObject {
    func praparePage()
}

final class DetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dogDescription: UITextView!
    
    var imgBig = UIImage()
    var titleBig = String()
    var getDescription = String()
    
    private lazy var viewModel = DetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
        
    }
}

extension DetailViewController: DetailViewControllerInterface {
    func praparePage() {
        detailLabel.text = titleBig
        dogDescription.text = getDescription
        detailImage.image = imgBig
    }
    
    
}
