//
//  TabItem.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

enum TabItem: String, Identifiable, CaseIterable {
    case quote, authors, categories
    
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .quote: "Zitat"
        case .authors: "Autor:innen"
        case .categories: "Kategorien"
        }
    }
    
    var icon: String {
        switch self {
        case .quote: "quote.closing"
        case .authors: "person.crop.artframe"
        case .categories: "square.grid.2x2"
        }
    }
    
    var view: some View {
        Group {
            switch self {
            case .quote: QuoteView()
            case .authors: AuthorListView()
            case .categories: CategoryGridView()
            }
        }
    }
}
