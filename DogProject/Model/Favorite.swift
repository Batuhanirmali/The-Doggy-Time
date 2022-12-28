//
//  Favorite.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 29.11.2022.
//

import Foundation

struct Favorite: Decodable {
    let id: String?
    let name: String
    let breed: Breed?
}
