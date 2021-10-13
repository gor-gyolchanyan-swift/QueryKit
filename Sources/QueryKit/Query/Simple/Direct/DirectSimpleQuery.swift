//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct DirectSimpleQuery<QuerySuccess, QueryFailure>
where QueryFailure: Error {

    @inlinable
    public init(_ queryRoutine: @escaping () -> QueryResult) {
        self.queryRoutine = queryRoutine
    }

    @usableFromInline
    internal let queryRoutine: () -> QueryResult
}

extension DirectSimpleQuery {

    @inlinable
    public init(_ queryRoutine: @escaping () throws -> QuerySuccess)
    where QueryFailure == Error {
        self.init {
            QueryResult(catching: queryRoutine)
        }
    }

    @inlinable
    public init(_ queryRoutine: @escaping () -> QuerySuccess)
    where QueryFailure == Never {
        self.init {
            QueryResult.success(queryRoutine())
        }
    }
}

extension DirectSimpleQuery: SimpleQueryProtocol {

    public typealias QueryResult = Result<QuerySuccess, QueryFailure>

    @inlinable
    public func executeQuery() -> QueryResult {
        queryRoutine()
    }
}
