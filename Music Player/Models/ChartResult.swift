import Foundation

struct ChartResult: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let results: [ChartEntry]
}
