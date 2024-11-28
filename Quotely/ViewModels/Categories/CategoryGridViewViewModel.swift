//
//  CategorGridViewViewModel.swift
//  Quotely
//
//  Created by Till Hemmerich on 28.11.24.
//

import Foundation
import SwiftUI

class CategoryGridViewViewModel : ObservableObject{
    
    let columns = Array(repeating: GridItem(spacing: 16), count: 2)
    
    @Published var categories: [Category] = []
    
    func fetchCategories() {
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
