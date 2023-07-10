import Foundation

struct Meal: Codable {
    /// API Fields
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    /// Computed Fields
    
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
