//
//  UpdateButton.swift
//  Quotely
//
//  Created by Kevin Waltz on 18.10.24.
//

import SwiftUI

struct UpdateButton: View {
    
    // MARK: - Properties
    
    let action: () -> Void
    
    
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            Label("Neues Zitat", systemImage: "arrow.clockwise")
                .font(.headline)
                .foregroundStyle(.syntaxDeepPurple)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.syntaxYellow)
        .clipShape(Capsule())
    }
    
}

#Preview {
    UpdateButton { }
}
