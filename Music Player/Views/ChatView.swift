import SwiftUI

struct ChartView: View {
    @State private var chartEntries: [ChartEntry] = []
    @State private var selectedCountry: String = "de"
    @State private var isLoading = true

    private let countries = ["de": "🇩🇪", "us": "🇺🇸", "fr": "🇫🇷", "jp": "🇯🇵", "gb": "🇬🇧"]

    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView()
                    .onAppear {
                        Task {
                            await fetchChartData()
                        }
                    }
            } else {
                List(chartEntries) { entry in
                    NavigationLink(destination: SongDetailView(entry: entry)) {
                        HStack {
                            AsyncImage(url: URL(string: entry.artworkUrl100)) { image in
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
                                Text(entry.name)
                                    .font(.headline)
                                Text(entry.artistName)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .navigationTitle("Top Songs")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Select Country", selection: $selectedCountry) {
                                ForEach(Array(countries.keys), id: \.self) { countryCode in
                                    HStack {
                                        Text(countries[countryCode] ?? "")
                                        Text(countries[countryCode] ?? countryCode)
                                    }
                                    .tag(countryCode)
                                }
                            }
                        } label: {
                            Text(countries[selectedCountry] ?? "🇩🇪")
                                .font(.largeTitle)
                        }
                    }
                }
                .onChange(of: selectedCountry) {
                    Task {
                        await fetchChartData()
                    }
                }
            }
        }
    }

    private func fetchChartData() async {
        isLoading = true
        do {
            chartEntries = try await NetworkService.shared.fetchChartData(for: selectedCountry)
        } catch {
            print("Error fetching chart data: \(error)")
        }
        isLoading = false
    }
}

#Preview {
    ChartView()
}
