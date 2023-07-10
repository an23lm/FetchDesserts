import SwiftUI

struct DessertListView: View {
    
    let viewModel = MealViewModel()
    @State var desserts: [Meal]? = nil
    
    @Sendable func refreshData() async {
        do {
            let desserts = try await viewModel.getDesserts()
            self.desserts = desserts
            print("loaded")
        } catch {
            print(error)
            // Handle Error
        }
    }
    
    var body: some View {
            NavigationView {
                ZStack {
                    if desserts == nil {
                        ProgressView("Loading...")
                    }
                    List(desserts ?? [], id: \.idMeal) { meal in
                        NavigationLink {
                            DessertDetailView(mealID: meal.idMeal, mealTitle: meal.strMeal)
                        } label: {
                            DessertCell(meal: meal)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle(Text("Desserts"))
                    .refreshable(action: refreshData)
                }
            }
            .task(refreshData)
        }
}

struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
