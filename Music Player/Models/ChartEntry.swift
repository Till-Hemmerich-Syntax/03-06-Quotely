import Foundation

struct ChartEntry: Identifiable, Codable {
    let id = UUID()
    let name: String
    let artistName: String
    let artworkUrl100: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case artistName
        case artworkUrl100
        case url
    }
}
