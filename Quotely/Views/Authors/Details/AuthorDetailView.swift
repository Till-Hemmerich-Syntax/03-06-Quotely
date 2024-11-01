//
//  AuthorDetailView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct AuthorDetailView: View {
    
    // MARK: - Properties
    
    let author: Author
    
    @State private var quotes: [Quote] = []
    
    
    
    // MARK: - Body
    
    var body: some View {
        List(quotes) { quote in
            VStack(spacing: 8) {
                Text(quote.text)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(quote.author)
                    .font(.footnote)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle(author.name)
        .task {
            fetchQuotes()
        }
    }
    
    
    
    // MARK: - Functions
    
    private func fetchQuotes() {
        guard quotes.isEmpty else { return }
        
        Task {
            do {
                quotes = try await getQuotesFromAPI()
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error)
            }
        }
    }
    
    private func getQuotesFromAPI() async throws -> [Quote] {
        let urlString = "https://api.syntax-institut.de/quotes?limit=20&slug=\(author.slug)&key=hLJiQcaMq9hjLfvYFEYcUD1y5Qxd7Bz5"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Quote].self, from: data)
    }
}

#Preview {
    AuthorDetailView(author: Author(id: UUID().uuidString, name: "Albert Einstein", slug: "albert-einstein"))
}
