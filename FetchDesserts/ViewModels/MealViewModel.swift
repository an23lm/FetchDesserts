struct MealViewModel {
    let apiService: APIService = APIService()
    
    func getDesserts() async throws -> [Meal] {
        return try await apiService.load(Meal.forCategory("Dessert")).meals ?? []
    }
    
    func getMeal(forID id: String) async throws -> Meal? {
        let intId: Int = Int(id)!
        return try await apiService.load(Meal.forMealID(intId)).meals?.first
    }
}
