//
//  String+Extension.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 25.11.2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
