import SwiftUI

struct CachedAsyncImage: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
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
        CachedAsyncImage(url: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    }
}
