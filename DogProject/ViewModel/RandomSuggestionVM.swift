//
//  RandomSuggestionVM.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.12.2022.
//

import Foundation

class DogImageViewModel {
    // MARK: - Properties
    let urlString = "https://dog.ceo/api/breeds/image/random"
    var imageURL: String? {
        didSet {
            // Notify any listeners that the image URL has been updated
            imageURLUpdated?()
        }
    }
    var imageURLUpdated: (() -> Void)?

    // MARK: - Helper Methods
    func fetchRandomDogImage() {
        guard let url = URL(string: urlString) else {
            print("Issue converting the url string.")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                //handle error here
                print(error?.localizedDescription ?? "No description but failed to get data.")
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(DogAPIResponse.self, from: data)
                self?.imageURL = jsonResult.message.absoluteString
            } catch {
                // Handle any converting issues/errors here
                print(error)
            }
        }
        task.resume()
    }
}
