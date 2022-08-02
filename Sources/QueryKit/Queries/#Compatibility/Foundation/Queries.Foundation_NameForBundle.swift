//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(Foundation)
    import class Foundation.Bundle

    extension Queries {

        // MARK: Queries - Foundation_NameForBundle

        @frozen
        public struct Foundation_NameForBundle<BundleQuery>
        where BundleQuery: Query, BundleQuery.Success == Foundation.Bundle {

            // MARK: Queries.Foundation_NameForBundle

            @inlinable
            public init(bundleQuery: BundleQuery) {
                self.bundleQuery = bundleQuery
            }

            @usableFromInline
            internal let bundleQuery: BundleQuery
        }
    }
    extension Queries.Foundation_NameForBundle {

        // MARK: Queries.Foundation_NameForBundle

        @inlinable
        internal func execute(_ bundleQueryResult: Result<BundleQuery.Success, BundleQuery.Failure>) -> Result<Success, Failure> {
            switch bundleQueryResult {
                case .success(let bundle):
                    if let bundleDisplayName = bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
                        return .success(bundleDisplayName)
                    } else if let bundleName = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String {
                        return .success(bundleName)
                    } else {
                        return .failure(.noNameForBundle(bundle: bundle))
                    }
                case .failure(let bundleQueryFailure):
                    return .failure(.bundleQueryFailure(bundleQuery: bundleQuery, bundleQueryFailure: bundleQueryFailure))
            }
        }
    }
extension Queries.Foundation_NameForBundle: Query {

        // MARK: Query

        public typealias Success = String

        @frozen
        public enum Failure: Error {

            // MARK: Queries.Foundation_NameForBundle.Failure

            case bundleQueryFailure(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.Failure)

            case noNameForBundle(bundle: Foundation.Bundle)
        }

        @inlinable
        public func execute() async -> Result<Success, Failure> {
            execute(await bundleQuery.execute())
        }
    }

    extension Queries.Foundation_NameForBundle: ImmediateQuery
    where BundleQuery: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            return execute(bundleQuery.execute())
        }
    }

    extension Query {

        // MARK: Queries.Foundation_NameForBundle

        @inlinable
        public static func name<BundleQuery>(forBundle bundleQuery: BundleQuery) -> Self
        where Self == Queries.Foundation_NameForBundle<BundleQuery> {
            Self(bundleQuery: bundleQuery)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.Foundation_NameForBundle

        @inlinable
        public static func name<BundleQuery>(forBundle bundleQuery: BundleQuery) -> Self
        where Self == Queries.Foundation_NameForBundle<BundleQuery> {
            Self(bundleQuery: bundleQuery)
        }
    }
#endif
