import SwiftUI
import AVFoundation

struct SongDetailView: View {
    let entry: ChartEntry
    @State private var songDetail: SongDetail?
    @State private var isLoading = true
    @State private var player: AVPlayer?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isLoading {
                    ProgressView()
                        .onAppear {
                            Task {
                                await fetchSongDetail()
                            }
                        }
                } else if let songDetail = songDetail {
                    AsyncImage(url: URL(string: songDetail.artworkUrl100)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    }

                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(songDetail.trackName)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .lineLimit(3)
                                .minimumScaleFactor(0.5)

                            Text(songDetail.artistName)
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)

                        Spacer()

                        Link(destination: URL(string: songDetail.trackViewUrl)!) {
                            Image("applemusic")
                                .resizable()
                                .frame(width: 150, height: 50)
                                .scaledToFill()
                        }
                    }
                    .padding(.horizontal)

                    Button(action: {
                        playPreview()
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Play Preview")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func fetchSongDetail() async {
        do {
            songDetail = try await NetworkService.shared.fetchSongDetail(for: entry.name)
        } catch {
            print("Error fetching song detail: \(error)")
        }
        isLoading = false
    }

    private func playPreview() {
        guard let previewUrlString = songDetail?.previewUrl,
              let previewUrl = URL(string: previewUrlString) else {
            return
        }
        player = AVPlayer(url: previewUrl)
        player?.play()
    }
}


#Preview {
    SongDetailView(entry: ChartEntry(name: "test", artistName: "test", artworkUrl100: "test", url: "test"))
}
