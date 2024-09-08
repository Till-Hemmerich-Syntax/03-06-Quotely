import Foundation

struct SongDetail: Identifiable, Codable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl100: String
    let trackViewUrl: String
    let previewUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl100
        case trackViewUrl
        case previewUrl
    }
}
