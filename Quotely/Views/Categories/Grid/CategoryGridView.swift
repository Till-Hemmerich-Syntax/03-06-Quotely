//
//  CategoriesView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct CategoryGridView: View {
    
    // MARK: - Properties
    
    private let columns = Array(repeating: GridItem(spacing: 16), count: 2)
    
    @State private var categories: [Category] = []
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categories, id: \.self) { category in
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
                fetchCategories()
            }
        }
    }
    
    
    
    // MARK: - Functions
    
    private func fetchCategories() {
        guard categories.isEmpty else { return }
        
        Task {
            do {
                let categories = try await getCategoriesFromAPI()
                self.categories = categories.map { Category(rawValue: $0) ?? .motivation }
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error)
            }
        }
    }
    
    private func getCategoriesFromAPI() async throws -> [String] {
        let urlString = "https://api.syntax-institut.de/categories"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([String].self, from: data)
    }
    
}

#Preview {
    CategoryGridView()
}
