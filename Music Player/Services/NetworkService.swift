import Foundation

class NetworkService {
    static let shared = NetworkService()

    func fetchChartData(for country: String) async throws -> [ChartEntry] {
        let urlString = "https://rss.applemarketingtools.com/api/v2/\(country)/music/most-played/10/songs.json"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ChartResult.self, from: data)
        return result.feed.results
    }

    func fetchSongDetail(for songName: String) async throws -> SongDetail? {
        let urlString = "https://itunes.apple.com/search?term=\(songName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entity=song&limit=1"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(SearchResult.self, from: data)
        return result.results.first
    }

    func searchSongs(query: String) async throws -> [SongDetail] {
        let urlString = "https://itunes.apple.com/search?term=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entity=song&limit=25"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(SearchResult.self, from: data)
        return result.results
    }
}
