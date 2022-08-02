//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(Foundation)
    import class Foundation.Bundle

    extension Queries {

        // MARK: Queries - Foundation_Bundle_AtPath

        @frozen
        public struct Foundation_Bundle_AtPath {

            // MARK: Queries.Foundation_Bundle_AtPath

            @inlinable
            public init(path: String) {
                self.path = path
            }

            @usableFromInline
            internal let path: String
        }
    }

    extension Queries.Foundation_Bundle_AtPath: Query {

        // MARK: Query

        public typealias Success = Foundation.Bundle

        @frozen
        public enum Failure: Error {

            // MARK: Queries.Foundation_Bundle_AtPath.Failure

            case noBundleAtPath(path: String)
        }
    }

    extension Queries.Foundation_Bundle_AtPath: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            guard let bundle = Foundation.Bundle(path: path) else {
                return .failure(.noBundleAtPath(path: path))
            }
            return .success(bundle)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.Foundation_Bundle_AtPath

        @inlinable
        public static func bundle(atPath path: String) -> Self
        where Self == Queries.Foundation_Bundle_AtPath {
            Self(path: path)
        }
    }
#endif
