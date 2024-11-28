//
//  CategoriesView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct CategoryGridView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = CategoryGridViewViewModel()
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        NavigationLink {
                            CategoryDetailView(category: category)
                        } label: {
                            CategoryView(category: category)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
            .navigationTitle(TabItem.categories.title)
            .task {
                viewModel.fetchCategories()
            }
        }
    }

    
}

#Preview {
    CategoryGridView()
}
