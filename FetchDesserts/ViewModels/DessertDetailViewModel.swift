import Foundation
import os

/// View Model for Dessert Detail View
///
/// - Parameters:
///   - mealID: String of the meal ID to be displayed on the detail view
///   - mealTitle: String of the meal title to be displayed on the detail view
///
@MainActor
class DessertDetailViewModel: ObservableObject {
    private let apiService: APIService
    private(set) var mealID: String
    private(set) var mealTitle: String
    private let logger = Logger(subsystem: "com.an23lm.FetchDesserts", category: "DessertDetailViewModel")
    
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var error: String? = nil
    @Published private(set) var meal: Meal? = nil
    
    init(mealID: String, mealTitle: String) {
        self.mealTitle = mealTitle.capitalized
        self.mealID = mealID
        self.apiService = APIService()
    }
    
    init(mealID: String, mealTitle: String, apiService: APIService) {
        self.mealTitle = mealTitle.capitalized
        self.mealID = mealID
        self.apiService = apiService
    }
    
    @Sendable func refreshData() async {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        
        do {
            self.meal = try await apiService.load(Meal.forMealID(self.mealID)).meals!.first!
            self.error = nil
            logger.debug("Detail Data Loaded for \(self.mealID)")
        } catch {
            logger.error("\(error.localizedDescription)")
            self.error = error.localizedDescription
        }
    }
}
