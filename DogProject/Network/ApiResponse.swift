//
//  ApiResponse.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 30.11.2022.
//

import Foundation

// MARK: Response

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
