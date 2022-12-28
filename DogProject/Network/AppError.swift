//
//  AppError.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 30.11.2022.
//

import Foundation

// MARK: Json error returns.
enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "bruhh!! I have no idea what go on"
        case .invalidUrl:
            return "Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}
