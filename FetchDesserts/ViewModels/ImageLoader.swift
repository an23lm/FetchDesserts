import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var url: URL!
    private var task: URLSessionDataTask?
    
    init(url: String) {
        guard let newUrl = URL(string: url) else {
            print("Invalid URL passed to ImageLoader \(url)")
            
            return
        }
        
        self.url = newUrl
        loadImage()
    }
    
    init(url: URL?) {
        guard (url != nil) else {
            print("Invalid URL passed to ImageLoader \(url?.absoluteString ?? "nil")")
            
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
