import SwiftUI
import os

/// View Model used by CachedAsyncImage
///
/// - Parameters:
///   - url: URL of the image to be loaded
///
@MainActor
class ImageLoader: ObservableObject {
    private var url: URL!
    private var task: URLSessionDataTask?
    private let logger = Logger(subsystem: "com.an23lm.FetchDesserts", category: "ImageLoader")
    
    @Published var image: UIImage?
    
    init(url: URL?) {
        guard (url != nil) else {
            logger.error("Invalid URL passed to ImageLoader \(url?.absoluteString ?? "nil")")
            
            return
        }
        
        self.url = url
        loadImage()
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }

        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
                ImageCache.shared.set(image!, forKey: self.url.absoluteString)
            }
        }
        task?.resume()
    }
}
