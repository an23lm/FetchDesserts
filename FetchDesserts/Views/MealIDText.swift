import SwiftUI

struct MealIDText: View {
    let mealID: String
    
    var body: some View {
        Text(mealID)
            .font(.system(.caption, design: .monospaced, weight: .semibold))
            .padding(4)
            .foregroundColor(.secondary)
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.quaternaryLabel))
            }
    }
}

struct MealIDText_Previews: PreviewProvider {
    static var previews: some View {
        MealIDText(mealID: "23456")
    }
}