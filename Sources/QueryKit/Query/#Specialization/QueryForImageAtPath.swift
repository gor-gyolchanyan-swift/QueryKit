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

@frozen
public struct QueryForImageInBundleAtPath {

    @inlinable
    public init(imagePath: String) {
        self.imagePath = imagePath
    }

    @usableFromInline
    internal let imagePath: String
}

extension QueryForImageInBundleAtPath: SimpleQueryProtocol {

    #if os(macOS)
        public typealias QuerySuccess = AppKit.NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias QuerySuccess = UIKit.UIImage
    #endif

    public enum QueryFailure: Error {

        case noImageAtPath(imagePath: String)
    }

    @inlinable
    public func executeQuery() -> QueryResult {
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
