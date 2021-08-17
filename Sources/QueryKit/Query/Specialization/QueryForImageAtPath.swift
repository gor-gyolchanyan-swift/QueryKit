//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

#if os(macOS)
    import class AppKit.NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
    import class UIKit.UIImage
#endif

import class Foundation.Bundle

public struct QueryForImageInBundleAtPath {

    // MARK: Type: QueryForImageInBundleAtPath

    public init(imagePath: String) {
        self.imagePath = imagePath
    }

    private let imagePath: String
}

extension QueryForImageInBundleAtPath: Query {

    // MARK: Type: Query

    #if os(macOS)
        public typealias QuerySuccess = AppKit.NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias QuerySuccess = UIKit.UIImage
    #endif

    public enum QueryFailure: Error {

        // MARK: Type: QueryForImageInBundleForName.QueryFailure

        case noImageAtPath(imagePath: String)
    }

    public mutating func executeQuery() -> QueryResult {
        #if os(macOS)
            guard let image = AppKit.NSImage(contentsOfFile: imagePath) else {
                return .failure(.noImageAtPath(imagePath: imagePath))
            }
            return .success(image)
        #elseif os(iOS) || os(tvOS) || os(watchOS)
            guard let image = UIKit.UIImage(contentsOfFile: imagePath) else {
                return .failure(.noImageAtPath(imagePath: imagePath))
            }
            return .success(image)
        #endif
    }
}
