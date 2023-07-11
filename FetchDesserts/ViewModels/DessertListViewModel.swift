import Foundation
import os

/// View Model for Dessert List View
///
@MainActor
class DessertListViewModel: ObservableObject {
    private let apiService: APIService
    private let logger = Logger(subsystem: "com.an23lm.FetchDesserts", category: "DessertListViewModel")
    
    @Published private(set) var meals: [Meal]? = nil
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String? = nil
    
    init() {
        self.apiService = APIService()
    }
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    @Sendable func refreshData() async {
        defer {
            self.isLoading = false
        }
        self.isLoading = true
        
        do {
            self.meals = try await apiService.load(Meal.forCategory("Dessert")).meals!
            self.error = nil
            logger.debug("List Data Loaded")
        } catch {
            logger.error("\(error.localizedDescription)")
            self.error = error.localizedDescription
        }
    }
}
