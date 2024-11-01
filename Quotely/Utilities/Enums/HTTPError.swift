//
//  HTTPError.swift
//  Quotely
//
//  Created by Kevin Waltz on 18.10.24.
//

import Foundation

enum HTTPError: Error {
    case invalidURL, fetchFailed
    
    var message: String {
        switch self {
        case .invalidURL: "Die URL ist ungültig"
        case .fetchFailed: "Laden ist fehlgeschlagen"
        }
    }
}
