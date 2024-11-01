//
//  Quote.swift
//  Quotely
//
//  Created by Kevin Waltz on 18.10.24.
//

import Foundation

struct Quote: Codable, Identifiable {
    var id: String
    var author: String
    var text: String
}
