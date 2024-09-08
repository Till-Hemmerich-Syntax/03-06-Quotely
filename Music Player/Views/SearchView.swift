import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [SongDetail] = []
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search songs...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        Task {
                            await searchSongs()
                        }
                    }) {
                        Text("Search")
                    }
                    .padding()
                }

                if isLoading {
                    ProgressView()
                } else {
                    List(searchResults) { song in
                        NavigationLink(destination: SongDetailView(entry: ChartEntry(name: song.trackName, artistName: song.artistName, artworkUrl100: song.artworkUrl100, url: song.trackViewUrl))) {
                            HStack {
                                AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(5)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }

                                VStack(alignment: .leading) {
                                    Text(song.trackName)
                                        .font(.headline)
                                    Text(song.artistName)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .navigationTitle("Search Songs")
                }
            }
        }
    }

    private func searchSongs() async {
        isLoading = true
        do {
            searchResults = try await NetworkService.shared.searchSongs(query: searchText)
        } catch {
            print("Error searching songs: \(error)")
        }
        isLoading = false
    }
}


#Preview {
    SearchView()
}
