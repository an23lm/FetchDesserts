import SwiftUI

@main
struct FetchDessertsApp: App {
    
    init() {
        let cache = Foundation.URLCache(memoryCapacity: 50_000_000, diskCapacity: 1_000_000_000)
        URLCache.shared = cache
    }
    
    var body: some Scene {
        WindowGroup {
            DessertListView(viewModel: DessertListViewModel())
        }
    }
}
