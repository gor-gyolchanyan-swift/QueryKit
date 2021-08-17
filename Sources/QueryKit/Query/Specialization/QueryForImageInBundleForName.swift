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

public struct QueryForImageInBundleForName<BundleQuery>
where BundleQuery: Query, BundleQuery.QuerySuccess == Foundation.Bundle {

    // MARK: Type: QueryForImageInBundleForName

    public init(bundleQuery: BundleQuery, imageName: String) {
        self.bundleQuery = bundleQuery
        self.imageName = imageName
    }

    private var bundleQuery: BundleQuery

    private let imageName: String
}

extension QueryForImageInBundleForName: Query {

    // MARK: Type: Query

    #if os(macOS)
        public typealias QuerySuccess = AppKit.NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias QuerySuccess = UIKit.UIImage
    #endif

    public enum QueryFailure: Error {

        // MARK: Type: QueryForImageInBundleForName.QueryFailure

        case bundleQueryFailure(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.QueryFailure)

        case noImageInBundleForName(bundle: Foundation.Bundle, imageName: String)
    }

    public mutating func executeQuery() -> QueryResult {
        switch bundleQuery.executeQuery() {
            case .success(let bundle):
                #if os(macOS)
                    guard let image = bundle.image(forResource: imageName) else {
                        return .failure(.noImageInBundleForName(bundle: bundle, imageName: imageName))
                    }
                    return .success(image)
                #elseif os(iOS) || os(tvOS) || os(watchOS)
                    guard let image = UIKit.UIImage(named: imageName, in: bundle, compatibleWith: nil) else {
                        return .failure(.noImageInBundleForName(bundle: bundle, imageName: imageName))
                    }
                    return .success(image)
                #endif
            case .failure(let bundleQueryFailure):
                return .failure(.bundleQueryFailure(bundleQuery: bundleQuery, bundleQueryFailure: bundleQueryFailure))
        }
    }
}
