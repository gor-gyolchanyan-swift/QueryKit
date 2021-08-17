//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

public struct DirectQuery<QuerySuccess, QueryFailure>
where QueryFailure: Error {

    // MARK: Type: DirectQuery

    public init(_ queryRoutine: @escaping () -> QueryResult) {
        self.queryRoutine = queryRoutine
    }

    private let queryRoutine: () -> QueryResult
}

extension DirectQuery {

    // MARK: Type: DirectQuery

    public init(_ queryRoutine: @escaping () throws -> QuerySuccess)
    where QueryFailure == Error {
        self.init {
            return QueryResult(catching: queryRoutine)
        }
    }

    public init(_ queryRoutine: @escaping () -> QuerySuccess)
    where QueryFailure == Never {
        self.init {
            return QueryResult.success(queryRoutine())
        }
    }
}

extension DirectQuery: Query {

    // MARK: Type: Query

    public typealias QueryResult = Result<QuerySuccess, QueryFailure>

    public func executeQuery() -> QueryResult {
        queryRoutine()
    }
}
