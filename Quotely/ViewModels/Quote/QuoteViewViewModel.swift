//
//  QuteViewViewModel.swift
//  Quotely
//
//  Created by Till Hemmerich on 28.11.24.
//

import Foundation

@MainActor
class QuoteViewViewModel : ObservableObject {
    
    @Published var quote: Quote?

    let dummyQuotes = [
        Quote(id: UUID().uuidString, author: "Abraham Maslow", text: "If you only have a hammer, you tend to see every problem as a nail."),
        Quote(id: UUID().uuidString, author: "Albert Einstein", text: "Life is like riding a bicycle. To keep your balance, you must keep moving."),
        Quote(id: UUID().uuidString, author: "Maya Angelou", text: "You will face many defeats in life, but never let yourself be defeated."),
        Quote(id: UUID().uuidString, author: "Confucius", text: "It does not matter how slowly you go as long as you do not stop."),
        Quote(id: UUID().uuidString, author: "Eleanor Roosevelt", text: "The future belongs to those who believe in the beauty of their dreams."),
        Quote(id: UUID().uuidString, author: "Nelson Mandela", text: "It always seems impossible until it’s done.")
    ]
    
    func fetchQuote() {
        Task {
            do {
                quote = try await getQuoteFromAPI()
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error)
            }
        }
    }
    
    private func getQuoteFromAPI() async throws -> Quote? {
        let urlString = "https://api.syntax-institut.de/quotes"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)

        return result.first
    }
}
