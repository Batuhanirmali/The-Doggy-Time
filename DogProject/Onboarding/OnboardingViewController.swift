//
//  OnboardingViewController.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.11.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "Breeds 🐶", description: "Here you will learn the characteristics of dog breeds and breeds, which group they belong to.", image: #imageLiteral(resourceName: "onboardDog1")),
            OnboardingSlide(title: "Food 🦴", description: "Here you will find a list of fruits and vegetables that dogs can eat and their benefits.", image: #imageLiteral(resourceName: "onboardDog2")),
            OnboardingSlide(title: "Name 🐾", description: "If you want to name your dog, if you need advice, you are at the right place.", image: #imageLiteral(resourceName: "onboardDog3"))
        ]
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "TabbarController") as! UITabBarController
            controller.modalPresentationStyle = .fullScreen
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true,completion: nil)
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: true)
            
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
