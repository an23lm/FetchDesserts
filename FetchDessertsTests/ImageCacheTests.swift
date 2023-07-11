//
//  ImageCacheTests.swift
//  FetchDessertsTests
//
//  Created by Anselm Joseph on 7/11/23.
//

import XCTest

final class ImageCacheTests: XCTestCase {

    func testSetGet() throws {
        guard let testImage = UIImage(systemName: "square.and.arrow.up.fill") else {
            assertionFailure("System image failed to load")
            return
        }
        
        ImageCache.shared.set(testImage, forKey: "test_img_1")
        
        let cachedImage = ImageCache.shared.get(forKey: "test_img_1")
        assert(cachedImage?.pngData() == testImage.pngData())
    }
    
    func testInvalidKeyGet() throws {
        let cachedImage = ImageCache.shared.get(forKey: "fail")
        
        assert(cachedImage == nil)
    }
    
    func testCacheOverlap() throws {
        guard let testImage = UIImage(systemName: "square.and.arrow.up.fill") else {
            assertionFailure("System image failed to load")
            return
        }
        
        guard let testImage2 = UIImage(systemName: "square.and.arrow.up") else {
            assertionFailure("System image failed to load")
            return
        }
        
        ImageCache.shared.set(testImage, forKey: "test_img_1")
        
        var cachedImage = ImageCache.shared.get(forKey: "test_img_1")
        assert(cachedImage?.pngData() == testImage.pngData())
        
        ImageCache.shared.set(testImage2, forKey: "test_img_1")
        
        cachedImage = ImageCache.shared.get(forKey: "test_img_1")
        assert(cachedImage?.pngData() == testImage2.pngData())
    }

}
