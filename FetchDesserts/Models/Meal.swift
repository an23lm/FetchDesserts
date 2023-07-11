import Foundation

/// Data structure representing a Meal
///
struct Meal: Codable {
    /// API Fields
    var idMeal: String
    var strMeal: String
    var strMealThumb: String?
    var strDrinkAlternate: String?
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
    var strTags: String?
    var strYoutube: String?
    var strSource: String?
    var strImageSource: String?
    var strCreativeCommonsConfirmed: String?
    var dateModified: String?
    
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    
    /// MARK :- Computed Fields
    
    var mealImageURL: URL? {
        get {
            if strMealThumb != nil {
                return URL(string: strMealThumb!);
            }
            
            return nil
        }
    }
    
    var mealThumbnailURL: URL? {
        get {
            if strMealThumb != nil {
                return URL(string: "\(strMealThumb!)/preview");
            }
            
            return nil
        }
    }
    
    var youtubeURL: URL? {
        get {
            if strYoutube != nil {
                return URL(string: strYoutube!)
            }
            
            return nil
        }
    }
    
    var sourceURL: URL? {
        get {
            if strSource != nil {
                return URL(string: strSource!)
            }
            
            return nil
        }
    }
    
    var imageSourceURL: URL? {
        get {
            if (strImageSource != nil) {
                return URL(string: strImageSource!)
            }
            
            return nil
        }
    }
    
    var ingredients: [(ingredient: String, measure: String)] {
        get {
            var allIngredients: [(ingredient: String, measure: String)] = [
                (ingredient: strIngredient1 ?? "", measure: strMeasure1 ?? ""),
                (ingredient: strIngredient2 ?? "", measure: strMeasure2 ?? ""),
                (ingredient: strIngredient3 ?? "", measure: strMeasure3 ?? ""),
                (ingredient: strIngredient4 ?? "", measure: strMeasure4 ?? ""),
                (ingredient: strIngredient5 ?? "", measure: strMeasure5 ?? ""),
                (ingredient: strIngredient6 ?? "", measure: strMeasure6 ?? ""),
                (ingredient: strIngredient7 ?? "", measure: strMeasure7 ?? ""),
                (ingredient: strIngredient8 ?? "", measure: strMeasure8 ?? ""),
                (ingredient: strIngredient9 ?? "", measure: strMeasure9 ?? ""),
                (ingredient: strIngredient10 ?? "", measure: strMeasure10 ?? ""),
                (ingredient: strIngredient11 ?? "", measure: strMeasure11 ?? ""),
                (ingredient: strIngredient12 ?? "", measure: strMeasure12 ?? ""),
                (ingredient: strIngredient13 ?? "", measure: strMeasure13 ?? ""),
                (ingredient: strIngredient14 ?? "", measure: strMeasure14 ?? ""),
                (ingredient: strIngredient15 ?? "", measure: strMeasure15 ?? ""),
                (ingredient: strIngredient16 ?? "", measure: strMeasure16 ?? ""),
                (ingredient: strIngredient17 ?? "", measure: strMeasure17 ?? ""),
                (ingredient: strIngredient18 ?? "", measure: strMeasure18 ?? ""),
                (ingredient: strIngredient19 ?? "", measure: strMeasure19 ?? ""),
                (ingredient: strIngredient20 ?? "", measure: strMeasure20 ?? ""),
            ]
            
            /// Include only items where ingredient is not empty
            allIngredients = allIngredients.filter({ item in
                !item.ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }).map({ (ingredient: String, measure: String) in
                return (ingredient: ingredient.trimmingCharacters(in: .whitespacesAndNewlines).capitalized, measure: measure.trimmingCharacters(in: .whitespacesAndNewlines))
            })
            
            return allIngredients
        }
    }
    
    var tags: String? {
        get {
            guard strTags != nil else {
                return nil
            }
            
            return strTags!.split(separator: ",").joined(separator: ", ").capitalized
        }
    }
    
    var instructions: String? {
        get {
            return strInstructions?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
