//
//  Image.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import Foundation

struct Result: Codable {
    let results: [UnsplashImage]
}

struct UnsplashImage: Codable, Identifiable {
    let id: String
    let urls: Urls
}

struct Urls: Codable {
    let small: URL
}
