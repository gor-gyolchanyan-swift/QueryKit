//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct DirectQuery<QuerySuccess, QueryFailure>
where QueryFailure: Error {

    @inlinable
    public init(_ queryRoutine: @escaping (_ resultHandler: @escaping QueryResultHandler) -> Void) {
        self.queryRoutine = queryRoutine
    }

    @usableFromInline
    internal let queryRoutine: (_ queryResultHandler: @escaping QueryResultHandler) -> Void
}

extension DirectQuery: QueryProtocol {

    public typealias QueryResult = Result<QuerySuccess, QueryFailure>

    public typealias QueryResultHandler = (QueryResult) -> Void

    @inlinable
    public func executeQuery(resultHandler: @escaping QueryResultHandler) {
        queryRoutine(resultHandler)
    }
}
