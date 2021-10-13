//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@usableFromInline
internal class AnyQueryCapsuleForQuery<BaseQuery>: AnyQueryAnyCapsule<BaseQuery.QuerySuccess, BaseQuery.QueryFailure>
where BaseQuery: QueryProtocol {

    @inlinable
    internal init(_ baseQuery: BaseQuery) {
        self.baseQuery = baseQuery
        super.init()
    }

    @inlinable
    deinit {
        /* This scope is intentionally left blank. */
    }

    @usableFromInline
    internal let baseQuery: BaseQuery

    // MARK: QueryProtocol

    @inlinable
    internal override func executeQuery(resultHandler: @escaping QueryResultHandler) {
        return baseQuery.executeQuery(resultHandler: resultHandler)
    }
}
