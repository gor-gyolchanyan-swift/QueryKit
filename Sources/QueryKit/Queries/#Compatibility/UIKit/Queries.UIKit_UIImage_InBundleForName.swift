//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(UIKit)
    import class UIKit.UIImage
    import class Foundation.Bundle

    extension Queries {

        // MARK: Queries - UIKit_UIImage_InBundleForName

        @frozen
        public struct UIKit_UIImage_InBundleForName<BundleQuery>
        where BundleQuery: Query, BundleQuery.Success == Foundation.Bundle {

            // MARK: Queries.UIKit_UIImage_InBundleForName

            @inlinable
            public init(bundleQuery: BundleQuery, name: String) {
                self.bundleQuery = bundleQuery
                self.name = name
            }

            @usableFromInline
            internal let bundleQuery: BundleQuery

            @usableFromInline
            internal let name: String
        }
    }


    extension Queries.UIKit_UIImage_InBundleForName {

        // MARK: Queries.UIKit_UIImage_InBundleForName

        @inlinable
        internal func execute(_ bundleQueryResult: Result<BundleQuery.Success, BundleQuery.Failure>) -> Result<Success, Failure> {
             switch bundleQueryResult {
                case .success(let bundle):
                     guard let image = UIKit.UIImage(named: name, in: bundle, compatibleWith: nil) else {
                         return .failure(.noImageInBundleForName(bundle: bundle, name: name))
                     }
                     return .success(image)
                case .failure(let bundleQueryFailure):
                    return .failure(.bundleQueryFailure(bundleQuery: bundleQuery, bundleQueryFailure: bundleQueryFailure))
            }
        }
    }

    extension Queries.UIKit_UIImage_InBundleForName: Query {

        // MARK: Query

        public typealias Success = UIKit.UIImage

        @frozen
        public enum Failure: Error {

            // MARK: Queries.UIKit_UIImage_InBundleForName.Failure

            case bundleQueryFailure(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.Failure)

            case noImageInBundleForName(bundle: Foundation.Bundle, name: String)
        }

        @inlinable
        public func execute() async -> Result<Success, Failure> {
            execute(await bundleQuery.execute())
        }
    }

    extension Queries.UIKit_UIImage_InBundleForName: ImmediateQuery
    where BundleQuery: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            return execute(bundleQuery.execute())
        }
    }

    extension Query {

        // MARK: Queries.UIKit_UIImage_InBundleForName

        @inlinable
        public static func image<BundleQuery>(inBundle bundleQuery: BundleQuery, forName name: String) -> Self
        where Self == Queries.UIKit_UIImage_InBundleForName<BundleQuery> {
            Self(bundleQuery: bundleQuery, name: name)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.UIKit_UIImage_InBundleForName

        @inlinable
        public static func image<BundleQuery>(inBundle bundleQuery: BundleQuery, forName name: String) -> Self
        where Self == Queries.UIKit_UIImage_InBundleForName<BundleQuery> {
            Self(bundleQuery: bundleQuery, name: name)
        }
    }
#endif
