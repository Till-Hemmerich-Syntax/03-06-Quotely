//
//  CategoryView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct CategoryView: View {
    
    // MARK: - Properties
    
    let category: Category
    
    
    
    // MARK: - Body
    
    var body: some View {
        Text(category.title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(24)
            .background(.syntaxYellow)
            .foregroundStyle(.syntaxDeepPurple)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
}

#Preview {
    CategoryView(category: .love)
}
