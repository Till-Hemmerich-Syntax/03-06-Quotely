//
//  InspirationView.swift
//  Quotely
//
//  Created by Kevin Waltz on 01.11.24.
//

import SwiftUI

struct InspirationView: View {
    
    // MARK: - Properties
    
    @State private var images: [UnsplashImage] = []
    
    
    private var leftImages: [UnsplashImage] {
        images.enumerated().compactMap { index, image in
            index % 2 != 0 ? image : nil
        }
    }
    
    private var rightImages: [UnsplashImage] {
        images.enumerated().compactMap { index, image in
            index % 2 == 0 ? image : nil
        }
    }
    
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(spacing: 16) {
                    ImagesColumView(images: leftImages)
                    ImagesColumView(images: rightImages)
                }
                .padding(16)
            }
            .navigationTitle(TabItem.inspiration.title)
            .task {
                fetchimages()
            }
        }
    }
    
    
    
    // MARK: - Functions
    
    private func fetchimages() {
        guard images.isEmpty else { return }
        
        Task {
            do {
                self.images = try await getImagesFromAPI()
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error)
            }
        }
    }
    
    private func getImagesFromAPI() async throws -> [UnsplashImage] {
        let urlString = "https://api.unsplash.com/search/photos/?query=motivation&page=1&per_page=24"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let headers = [
            "Authorization": "Client-ID N4HknMQvVuuMpIKow5r9uXU3U32ZGKnfpe0r-GrSbPA"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Result.self, from: data).results
    }
    
}

#Preview {
    InspirationView()
}
