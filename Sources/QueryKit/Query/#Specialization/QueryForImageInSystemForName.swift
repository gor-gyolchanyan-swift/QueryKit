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
public struct QueryForImageInSystemForName {

    @inlinable
    public init(imageName: String) {
        self.imageName = imageName
    }

    @usableFromInline
    internal let imageName: String
}

extension QueryForImageInSystemForName: SimpleQueryProtocol {

    #if os(macOS)
        public typealias QuerySuccess = AppKit.NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias QuerySuccess = UIKit.UIImage
    #endif

    public enum QueryFailure: Error {

        case notSupported

        case noImageInSystemForName(imageName: String)
    }

    @inlinable
    public func executeQuery() -> QueryResult {
        #if os(macOS)
            if #available(macOS 11.0, *) {
                guard let image = AppKit.NSImage(systemSymbolName: imageName, accessibilityDescription: nil) else {
                    return .failure(.noImageInSystemForName(imageName:imageName))
                }
                return .success(image)
            } else {
                return .failure(.notSupported)
            }
        #elseif os(iOS) || os(tvOS) || os(watchOS)
            if #available(iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
                guard let image = UIKit.UIImage(systemName: imageName) else {
                    return .failure(.noImageInSystemForName(imageName: imageName))
                }
                return .success(image)
            } else {
                return .failure(.notSupported)
            }
        #endif
    }
}
