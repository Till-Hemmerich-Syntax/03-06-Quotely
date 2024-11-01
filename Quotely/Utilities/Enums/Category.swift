//
//  Category.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import Foundation

enum Category: String, Identifiable, CaseIterable {
    case motivation, life, love, wisdom, success, happiness, courage, friendship, education, future
    
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .motivation: "Motivation"
        case .life: "Leben"
        case .love: "Liebe"
        case .wisdom: "Weisheit"
        case .success: "Erfolg"
        case .happiness: "Glück"
        case .courage: "Mut"
        case .friendship: "Freundschaft"
        case .education: "Bildung"
        case .future: "Zukunft"
        }
    }
}
