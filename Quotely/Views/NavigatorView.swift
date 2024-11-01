//
//  NavigatorView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct NavigatorView: View {
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            ForEach(TabItem.allCases) { tabItem in
                Tab(tabItem.title, systemImage: tabItem.icon) {
                    tabItem.view
                }
            }
        }
    }
    
}

#Preview {
    NavigatorView()
}
