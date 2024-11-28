//
//  QuoteView.swift
//  Quotely
//
//  Created by Kevin Waltz on 18.10.24.
//

import SwiftUI

struct QuoteView: View {
    // MARK: - ViewModel
    @StateObject var viewModel = QuoteViewViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
    
            /// Force Unwrap sollte normalerweise unbedingt vermieden werden
            /// In diesem Fall ist es aber okay, da wir zu 100% wissen, dass es ein Element im Array als Fallback gibt
            QuoteDetailView(quote: viewModel.quote ?? viewModel.dummyQuotes.randomElement()!)
            
            Spacer()
            
            UpdateButton(action: viewModel.fetchQuote)
        }
        .padding(.bottom, 24)
        .task {
            viewModel.fetchQuote()
        }
    }
  
}

#Preview {
    QuoteView()
}
