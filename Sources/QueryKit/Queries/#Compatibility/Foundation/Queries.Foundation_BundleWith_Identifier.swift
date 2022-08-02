//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(Foundation)
    import class Foundation.Bundle

    extension Queries {

        // MARK: Queries - Foundation_Bundle_WithIdentifier

        @frozen
        public struct Foundation_Bundle_WithIdentifier {

            // MARK: Queries.Foundation_Bundle_WithIdentifier

            @inlinable
            public init(identifier: String) {
                self.identifier = identifier
            }

            @usableFromInline
            internal let identifier: String
        }
    }

    extension Queries.Foundation_Bundle_WithIdentifier: Query {

        // MARK: Query

        public typealias Success = Foundation.Bundle

        @frozen
        public enum Failure: Error {

            // MARK: Queries.Foundation_Bundle_WithIdentifier.Failure

            case noBundleWithIdentifier(identifier: String)
        }
    }

    extension Queries.Foundation_Bundle_WithIdentifier: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            guard let bundle = Foundation.Bundle(identifier: identifier) else {
                return .failure(.noBundleWithIdentifier(identifier: identifier))
            }
            return .success(bundle)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.Foundation_Bundle_WithIdentifier

        @inlinable
        public static func bundle(withIdentifier identifier: String) -> Self
        where Self == Queries.Foundation_Bundle_WithIdentifier {
            Self(identifier: identifier)
        }
    }
#endif
