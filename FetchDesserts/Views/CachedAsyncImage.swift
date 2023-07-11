import SwiftUI

/// View which displays an image and manages caching
///
/// - Parameters:
///   - url: URL of the image to be displayed
///
struct CachedAsyncImage: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: URL?) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color.gray)
        } else {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(.quaternaryLabel))
                .aspectRatio(1/1, contentMode: .fit)
        }
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedAsyncImage(url:URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
    }
}
