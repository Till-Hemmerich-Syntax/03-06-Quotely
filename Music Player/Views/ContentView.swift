import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ChartView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Charts")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

#Preview {
    ContentView()
}
