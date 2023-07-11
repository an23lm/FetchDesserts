import SwiftUI

/// View which displays details of a meal such as thumbnail image, name, and meal ID.
///
/// - Parameters:
///   - meal: The `Meal` object to be displayed
///
struct DessertCell: View {
    let meal: Meal
    
    var body: some View {
        HStack(alignment: .top){
            CachedAsyncImage(url: meal.mealImageURL)
                .frame(width: 100)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(meal.strMeal.capitalized)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(Font.Weight.semibold)
                    .multilineTextAlignment(.leading)
                MealIDText(mealID: meal.idMeal)
            }
        }
    }
}

struct DessertCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let response =  """
        {
            "strMeal": "Apam balik",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
            "idMeal": "53049"
        }
        """
        
        let meal: Meal? = try? JSONDecoder().decode(Meal.self, from: response.data(using: .utf8)!)
        
        DessertCell(meal: meal!)
    }
}
