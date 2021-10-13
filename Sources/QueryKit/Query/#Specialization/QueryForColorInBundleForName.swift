//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

#if os(macOS)
    import class AppKit.NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
    import class UIKit.UIColor
#endif

import class Foundation.Bundle

@frozen
public struct QueryForColorInBundleForName<BundleQuery>
where BundleQuery: QueryProtocol, BundleQuery.QuerySuccess == Foundation.Bundle {

    @inlinable
    public init(bundleQuery: BundleQuery, colorName: String) {
        self.bundleQuery = bundleQuery
        self.colorName = colorName
    }

    @usableFromInline
    internal let bundleQuery: BundleQuery

    @usableFromInline
    internal let colorName: String
}

extension QueryForColorInBundleForName {

    @inlinable
    internal func executeQuery(_ bundleQueryResult: BundleQuery.QueryResult) -> QueryResult {
         switch bundleQueryResult {
            case .success(let bundle):
                #if os(macOS)
                    if #available(macOS 10.13, *) {
                        guard let color = AppKit.NSColor(named: colorName, bundle: bundle) else {
                            return .failure(.noColorInBundleForName(bundle: bundle, colorName: colorName))
                        }
                        return .success(color)
                    } else {
                        return .failure(.notSupported)
                    }
                #elseif os(iOS) || os(tvOS) || os(watchOS)
                    if #available(iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
                        guard let color = UIKit.UIColor(named: colorName, in: bundle, compatibleWith: nil) else {
                            return .failure(.noColorInBundleForName(bundle: bundle, colorName: colorName))
                        }
                        return .success(color)
                    } else {
                        return .failure(.notSupported)
                    }
                #endif
            case .failure(let bundleQueryFailure):
                return .failure(.bundleQueryFailure(bundleQuery: bundleQuery, bundleQueryFailure: bundleQueryFailure))
        }
    }
}

extension QueryForColorInBundleForName: QueryProtocol {

    #if os(macOS)
        public typealias QuerySuccess = AppKit.NSColor
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias QuerySuccess = UIKit.UIColor
    #endif

    public enum QueryFailure: Error {

        case notSupported

        case bundleQueryFailure(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.QueryFailure)

        case noColorInBundleForName(bundle: Foundation.Bundle, colorName: String)
    }

    @inlinable
    public func executeQuery(resultHandler: @escaping QueryResultHandler) {
        bundleQuery.executeQuery { bundleQueryResult in
            return resultHandler(executeQuery(bundleQueryResult))
        }
    }
}

extension QueryForColorInBundleForName: SimpleQueryProtocol
where BundleQuery: SimpleQueryProtocol {

    @inlinable
    public func executeQuery() -> QueryResult {
        return executeQuery(bundleQuery.executeQuery())
    }
}
