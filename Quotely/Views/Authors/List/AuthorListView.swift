//
//  AuthorsView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct AuthorListView: View {
    
    // MARK: - ViewModel
    @StateObject var viewModel = AuthorListViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List(viewModel.authors) { author in
                NavigationLink {
                    AuthorDetailView(author: author)
                } label: {
                    Text(author.name)
                }
            }
            .navigationTitle(TabItem.authors.title)
        }
        .task {
            viewModel.fetchAuthors()
        }
    }
    
}

#Preview {
    AuthorListView()
}
