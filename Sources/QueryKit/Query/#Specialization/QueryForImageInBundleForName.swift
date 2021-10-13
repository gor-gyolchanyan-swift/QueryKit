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
public struct QueryForImageInBundleForName<BundleQuery>
where BundleQuery: QueryProtocol, BundleQuery.QuerySuccess == Foundation.Bundle {

    @inlinable
    public init(bundleQuery: BundleQuery, imageName: String) {
        self.bundleQuery = bundleQuery
        self.imageName = imageName
    }

    @usableFromInline
    internal let bundleQuery: BundleQuery

    @usableFromInline
    internal let imageName: String
}

extension QueryForImageInBundleForName {

    #if os(macOS)
        public typealias QuerySuccess = AppKit.NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias QuerySuccess = UIKit.UIImage
    #endif

    public enum QueryFailure: Error {

        case bundleQueryFailure(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.QueryFailure)

        case noImageInBundleForName(bundle: Foundation.Bundle, imageName: String)
    }

    @inlinable
    internal func executeQuery(_ bundleQueryResult: BundleQuery.QueryResult) -> QueryResult {
        switch bundleQueryResult {
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

extension QueryForImageInBundleForName: QueryProtocol {

    @inlinable
    public func executeQuery(resultHandler: @escaping QueryResultHandler) {
        bundleQuery.executeQuery { bundleQueryResult in
            return resultHandler(executeQuery(bundleQueryResult))
        }
    }
}

extension QueryForImageInBundleForName: SimpleQueryProtocol
where BundleQuery: SimpleQueryProtocol {

    @inlinable
    public func executeQuery() -> QueryResult {
        return executeQuery(bundleQuery.executeQuery())
    }
}
