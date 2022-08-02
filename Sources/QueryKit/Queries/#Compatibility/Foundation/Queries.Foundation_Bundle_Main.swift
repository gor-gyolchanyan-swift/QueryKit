//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(Foundation)
    import class Foundation.Bundle

    extension Queries {

        // MARK: Queries - Foundation_Bundle_Main

        @frozen
        public struct Foundation_Bundle_Main {

            // MARK: Queries.Foundation_Bundle_Main

            @inlinable
            public init() { }
        }
    }

    extension Queries.Foundation_Bundle_Main: Query {

        // MARK: Query

        public typealias Success = Foundation.Bundle

        public typealias Failure = Never
    }

    extension Queries.Foundation_Bundle_Main: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            return .success(Foundation.Bundle.main)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.Foundation_Bundle_Main

        @inlinable
        public static func mainBundle() -> Self
        where Self == Queries.Foundation_Bundle_Main {
            Self()
        }
    }
#endif
