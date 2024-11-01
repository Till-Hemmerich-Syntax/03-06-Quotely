//
//  AuthorsView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct AuthorListView: View {
    
    // MARK: - Properties
    
    @State private var authors: [Author] = []
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List(authors) { author in
                NavigationLink {
                    AuthorDetailView(author: author)
                } label: {
                    Text(author.name)
                }
            }
            .navigationTitle(TabItem.authors.title)
        }
        .task {
            fetchAuthors()
        }
    }
    
    
    
    // MARK: - Functions
    
    private func fetchAuthors() {
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
<<<<<<< HEAD
        let urlString = "https://api.syntax-institut.de/authors?key=UaLxT0P1vhTVun5YKj7XhdYyoLYFNtOy"
=======
        let urlString = "https://api.syntax-institut.de/authors?key=\(APIKeys.quotes)"
>>>>>>> solution-weiterfuehrend
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Author].self, from: data)
    }
    
}

#Preview {
    AuthorListView()
}
