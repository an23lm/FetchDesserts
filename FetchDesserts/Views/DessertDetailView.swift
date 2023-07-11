import SwiftUI
import os

/// View which displays the details of a selected meal
///
/// - Parameters:
///   - viewModel: DessertDetailViewModel
///
struct DessertDetailView: View {
    @ObservedObject var viewModel: DessertDetailViewModel
    private let logger = Logger(subsystem: "com.an23lm.FetchDesserts", category: "DessertDetailView")
    
    func openWebpage(withURL url: URL?) -> () -> () {
        return {
            if url != nil && UIApplication.shared.canOpenURL(url!) {
                logger.debug("Opening URL: \(url!.absoluteString)")
                UIApplication.shared.open(url!)
            } else {
                let _ = Alert(title: Text("Something went wrong when opening the link"),
                              message: Text("Here's the link:\n\(url!)"))
            }
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if viewModel.meal == nil || viewModel.error != nil {
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
                ScrollView {
                    VStack {
                        // group for meal image, name, cusine, tags and id
                        Group {
                            CachedAsyncImage(url: viewModel.meal?.mealImageURL)
                                .cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(viewModel.mealTitle)
                                    .font(.system(.title, design: .serif, weight: .semibold))
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Cusine")
                                            .font(.system(.caption2, design: .rounded))
                                        Text(viewModel.meal?.strArea?.capitalized ?? "Unknown")
                                            .font(.system(.headline, design: .serif))
                                    }
                                    Spacer()
                                    MealIDText(mealID: viewModel.mealID)
                                }
                                VStack(alignment: .leading) {
                                    Text("Tags")
                                        .font(.system(.caption2, design: .rounded))
                                    Text(viewModel.meal!.tags ?? "")
                                        .font(.system(.headline, design: .serif))
                                }.isHidden(viewModel.meal!.tags, remove: true)
                            }
                        }
                        Divider().padding()
                        // group for ingredients
                        Group {
                            Text("Ingredients")
                                .font(.system(.title, design: .serif, weight: .semibold))
                                .padding(.bottom, 8)
                            VStack(spacing: 0) {
                                ForEach(Array(zip(viewModel.meal!.ingredients.indices, viewModel.meal!.ingredients)), id: \.0) { index, item in
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
                        // group for instructions
                        Group {
                            Text("Instructions")
                                .font(.system(.title, design: .serif, weight: .semibold))
                                .padding(.bottom, 8)
                            
                            Text(viewModel.meal?.instructions ?? "No instructions available")
                                .kerning(0.2)
                                .multilineTextAlignment(.leading)
                                .font(.system(.body, design: .rounded))
                                .lineSpacing(2)
                        }
                        Divider().padding()
                        // Group for CTA buttons
                        Group {
                            
                            Button(action: openWebpage(withURL: viewModel.meal!.youtubeURL)) {
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
                            }.isHidden(viewModel.meal!.youtubeURL, remove: true)
                            
                            Button(action: openWebpage(withURL: viewModel.meal!.sourceURL)) {
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
                            }.isHidden(viewModel.meal!.sourceURL, remove: true)
                            
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .refreshable(action: viewModel.refreshData)
            }
        }
        .navigationTitle(Text(viewModel.mealTitle))
        .task(viewModel.refreshData)
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(viewModel: DessertDetailViewModel(mealID: "52767", mealTitle: "Test Dessert"))
    }
}
