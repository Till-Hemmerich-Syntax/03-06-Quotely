//
//  ImagesColumView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct ImagesColumView: View {
    
    // MARK: - Properties
    
    let images: [UnsplashImage]
    
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(images) { image in
                AsyncImage(url: image.urls.small) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "camera.fill")
                        .padding(16)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Spacer()
        }
    }
    
}

#Preview {
    ImagesColumView(images: [])
}
