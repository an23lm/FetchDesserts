import SwiftUI

/// View which displays a list of desserts available on MealDB
///
/// - Parameters:
///   - viewModel: DessertListViewModel
///
struct DessertListView: View {
    
    @ObservedObject var viewModel: DessertListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.meals == nil || viewModel.error != nil {
                    VStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(Color.yellow)
                        Text("Oh no! Something went wrong")
                        Text(viewModel.error ?? "")
                            .isHidden(viewModel.error, remove: true)
                    }
                } else {
                    List(viewModel.meals!, id: \.idMeal) { meal in
                        NavigationLink {
                            DessertDetailView(viewModel: DessertDetailViewModel(mealID: meal.idMeal, mealTitle: meal.strMeal))
                        } label: {
                            DessertCell(meal: meal)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable(action: viewModel.refreshData)
                }
            }
            .navigationTitle(Text("Desserts"))
        }
        .task(viewModel.refreshData)
    }
}

struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView(viewModel: DessertListViewModel())
    }
}
