import SwiftUI

struct DessertDetailView: View {
    var mealID: String
    var mealTitle: String
    let viewModel = MealViewModel()
    @State var meal: Meal? = nil
    
    @Sendable func reloadData() async {
        do {
            let meal = try await viewModel.getMeal(forID: mealID)
            self.meal = meal
        } catch {
            // Handle error
        }
    }
    
    func openYTURL() {
        if meal?.youtubeURL != nil && UIApplication.shared.canOpenURL(meal!.youtubeURL!) {
            
            print("opening URL")
            UIApplication.shared.open(meal!.youtubeURL!)
        } else {
            let _ = Alert(title: Text("Something went wrong when opening the link"),
                          message: Text("Here's the link:\n\(meal!.strYoutube!)"))
        }
    }
    
    var body: some View {
        ZStack {
            if meal == nil {
                ProgressView("Loading...")
            } else {
                ScrollView {
                    VStack {
                        Group {
                            CachedAsyncImage(url: meal!.mealImageURL).cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(mealTitle.capitalized)
                                    .font(.system(.title, design: .serif, weight: .semibold))
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Cusine")
                                            .font(.system(.caption2, design: .rounded))
                                        Text(meal!.strArea?.capitalized ?? "Unknown")
                                            .font(.system(.headline, design: .serif))
                                    }
                                    Spacer()
                                    MealIDText(mealID: mealID)
                                }
                                VStack(alignment: .leading) {
                                    Text("Tags")
                                        .font(.system(.caption2, design: .rounded))
                                    Text(meal!.tags ?? "")
                                        .font(.system(.headline, design: .serif))
                                }.isHidden(meal!.tags, remove: true)
                            }
                        }
                        Divider().padding()
                        Group {
                            Text("Ingredients")
                                .font(.system(.title, design: .serif, weight: .semibold))
                                .padding(.bottom, 8)
                            VStack(spacing: 0) {
                                ForEach(Array(zip(meal!.ingredients.indices, meal!.ingredients)), id: \.0) { index, item in
                                    HStack() {
                                        Text(item.ingredient.capitalized)
                                            .font(.system(.body, design: .rounded, weight: .semibold))
                                        Spacer()
                                        Text(item.measure)
                                            .font(.system(.body, design: .monospaced, weight: .semibold))
                                    }
                                    .padding()
                                    .background(index % 2 == 0 ? Color(.quaternaryLabel) : Color.clear)
                                    .cornerRadius(8)
                                }
                            }
                        }
                        Divider().padding()
                        Group {
                            Text("Instructions")
                                .font(.system(.title, design: .serif, weight: .semibold))
                                .padding(.bottom, 8)
                            
                            Text(meal!.instructions ?? "No instructions available")
                                .kerning(0.2)
                                .multilineTextAlignment(.leading)
                                .font(.system(.body, design: .rounded))
                                .lineSpacing(2)
                        }
                        Divider().padding()
                        Group {
                            Button(action: openYTURL) {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(.sRGB, red: 254/255, green: 0/255, blue: 0/255))
                                    .overlay(alignment: .leading) {
                                        ZStack(alignment: .leading) {
                                            Image("YTLogo")
                                                .renderingMode(.original)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding(14)
                                            HStack {
                                                Spacer()
                                                Text("Watch and Cook")
                                                    .font(.system(.headline, weight: .semibold))
                                                    .foregroundColor(.white)
                                                Spacer()
                                            }
                                            .padding(8)
                                        }
                                    }
                                    .frame(height: 50)
                                    .clipped()
                            }.isHidden(meal!.youtubeURL, remove: true)
                        }
                        Group {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.systemGray6))
                                .overlay(alignment: .leading) {
                                    ZStack(alignment: .leading) {
                                        Image(systemName: "safari.fill")
                                            .imageScale(.large)
                                            .symbolRenderingMode(.hierarchical)
                                            .padding()
                                        HStack {
                                            Spacer()
                                            Text("Visit Website")
                                                .font(.system(.headline, weight: .semibold))
                                                .foregroundColor(.secondary)
                                            Spacer()
                                        }
                                        .padding(8)
                                    }
                                }
                                .frame(height: 50)
                                .clipped()
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .refreshable(action: reloadData)
            }
        }
        .navigationTitle(Text(mealTitle.capitalized))
        .task(reloadData)
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(mealID: "52767", mealTitle: "Apam balik")
    }
}
