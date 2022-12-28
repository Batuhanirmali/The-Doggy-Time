//
//  AllBreed.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 30.11.2022.
//

import Foundation


struct AllBreed: Decodable {
    let categories: [DogCategory]?
    let populars: [Breed]?
    let downCategories: [Breed]?
}
