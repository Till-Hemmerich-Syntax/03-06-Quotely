//
//  QuoteDetailView.swift
//  Quotely
//
//  Created by Kevin Waltz on 18.10.24.
//

import SwiftUI

struct QuoteDetailView: View {
    
    // MARK: - Properties
    
    let quote: Quote
    
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 36) {
            Image(systemName: "quote.opening")
                .font(.largeTitle)
                .foregroundStyle(.syntaxPurple)
            
            VStack(spacing: 16) {
                Text(quote.text)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Text(quote.author)
                    .font(.body)
                    .italic()
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(24)
        .background(.syntaxGray)
        .clipShape(RoundedRectangle(cornerRadius: 36))
        .shadow(color: .gray.opacity(0.5), radius: 24)
        .padding(.horizontal, 36)
    }
    
}

#Preview {
    QuoteDetailView(quote: Quote(id: UUID().uuidString,
                                 author: "Abraham Maslow",
                                 text: "If you only have a hammer, you tend to see every problem as a nail."))
}
