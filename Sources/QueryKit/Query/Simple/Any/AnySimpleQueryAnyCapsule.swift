//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@usableFromInline
internal class AnySimpleQueryAnyCapsule<QuerySuccess, QueryFailure>: SimpleQueryProtocol
where QueryFailure: Error {

    @inlinable
    init() {
        /* This routine is intentionally left blank. */
    }

    @inlinable
    deinit {
        /* This scope is intentionally left blank. */
    }

    // MARK: QueryProtocol

    @usableFromInline
    internal typealias QueryResult = Result<QuerySuccess, QueryFailure>

    @usableFromInline
    internal typealias QueryResultHandler = (QueryResult) -> Void

    @inlinable
    internal func executeQuery(resultHandler: @escaping QueryResultHandler) {
        preconditionFailure("execution has reached a routine that should have been overridden")
    }

    // MARK: SimpleQueryProtocol

    @inlinable
    internal func executeQuery() -> QueryResult {
        preconditionFailure("execution has reached a routine that should have been overridden")
    }
}
