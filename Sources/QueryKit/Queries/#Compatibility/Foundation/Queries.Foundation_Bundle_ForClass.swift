//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(Foundation)
    import class Foundation.Bundle

    extension Queries {

        // MARK: Queries - Foundation_Bundle_ForClass

        @frozen
        public struct Foundation_Bundle_ForClass<ClassQuery>
        where ClassQuery: Query, ClassQuery.Success == AnyClass {

            // MARK: Queries.Foundation_Bundle_ForClass

            @inlinable
            public init(classQuery: ClassQuery) {
                self.classQuery = classQuery
            }

            @usableFromInline
            internal let classQuery: ClassQuery
        }
    }

    extension Queries.Foundation_Bundle_ForClass {

        // MARK: Queries.Foundation_Bundle_ForClass

        @inlinable
        internal func execute(_ classQueryResult: Result<ClassQuery.Success, ClassQuery.Failure>) -> Result<Success, Failure> {
            switch classQueryResult {
                case .success(let `class`):
                    let bundle = Foundation.Bundle(for: `class`)
                    return .success(bundle)
                case .failure(let classQueryFailure):
                    return .failure(.classQueryFailure(classQuery: classQuery, classQueryFailure: classQueryFailure))
            }
        }
    }

    extension Queries.Foundation_Bundle_ForClass: Query {

        // MARK: Query

        public typealias Success = Foundation.Bundle

        @frozen
        public enum Failure: Error {

            // MARK: Queries.Foundation_Bundle_ForClass.Failure

            case classQueryFailure(classQuery: ClassQuery, classQueryFailure: ClassQuery.Failure)
        }

        @inlinable
        public func execute() async -> Result<Success, Failure> {
            execute(await classQuery.execute())
        }
    }

    extension Queries.Foundation_Bundle_ForClass: ImmediateQuery
    where ClassQuery: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            return execute(classQuery.execute())
        }
    }

    extension Query {

        // MARK: Bundle.QueryForClass

        @inlinable
        public static func bundle<ClassQuery>(forClass classQuery: ClassQuery) -> Self
        where Self == Queries.Foundation_Bundle_ForClass<ClassQuery> {
            Self(classQuery: classQuery)
        }
    }

    extension ImmediateQuery {

        // MARK: Bundle.QueryForClass

        @inlinable
        public static func bundle<ClassQuery>(forClass classQuery: ClassQuery) -> Self
        where Self == Queries.Foundation_Bundle_ForClass<ClassQuery> {
            Self(classQuery: classQuery)
        }
    }
#endif
