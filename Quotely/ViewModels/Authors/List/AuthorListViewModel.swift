//
//  AuthorListViewmodel.swift
//  Quotely
//
//  Created by Till Hemmerich on 28.11.24.
//

import Foundation

class AuthorListViewModel: ObservableObject{
    
    @Published var authors: [Author] = []
    
    func fetchAuthors() {
        guard authors.isEmpty else { return }
        
        Task {
            do {
                authors = try await getAuthorsFromAPI()
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error)
            }
        }
    }
    
    private func getAuthorsFromAPI() async throws -> [Author] {
        let urlString = "https://api.syntax-institut.de/authors?key=\(APIKeys.quotes)"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Author].self, from: data)
    }

}
