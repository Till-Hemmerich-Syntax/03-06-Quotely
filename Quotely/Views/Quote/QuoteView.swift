//
//  QuoteView.swift
//  Quotely
//
//  Created by Kevin Waltz on 18.10.24.
//

import SwiftUI

struct QuoteView: View {
    
    // MARK: - Properties
    
    private let dummyQuotes = [
        Quote(id: UUID().uuidString, author: "Abraham Maslow", text: "If you only have a hammer, you tend to see every problem as a nail."),
        Quote(id: UUID().uuidString, author: "Albert Einstein", text: "Life is like riding a bicycle. To keep your balance, you must keep moving."),
        Quote(id: UUID().uuidString, author: "Maya Angelou", text: "You will face many defeats in life, but never let yourself be defeated."),
        Quote(id: UUID().uuidString, author: "Confucius", text: "It does not matter how slowly you go as long as you do not stop."),
        Quote(id: UUID().uuidString, author: "Eleanor Roosevelt", text: "The future belongs to those who believe in the beauty of their dreams."),
        Quote(id: UUID().uuidString, author: "Nelson Mandela", text: "It always seems impossible until it’s done.")
    ]
    
    @State private var quote: Quote?
    
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            /// Force Unwrap sollte normalerweise unbedingt vermieden werden
            /// In diesem Fall ist es aber okay, da wir zu 100% wissen, dass es ein Element im Array als Fallback gibt
            QuoteDetailView(quote: quote ?? dummyQuotes.first!)
            
            Spacer()
            
            UpdateButton(action: fetchQuote)
        }
        .padding(.bottom, 24)
        .task {
            fetchQuote()
        }
    }
    
    
    
    // MARK: - Functions
    
    private func fetchQuote() {
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

#Preview {
    QuoteView()
}
