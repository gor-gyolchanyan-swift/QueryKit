//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct AnySimpleQuery<QuerySuccess, QueryFailure>
where QueryFailure: Error {

    @usableFromInline
    internal typealias AnyCapsule = AnySimpleQueryAnyCapsule<QuerySuccess, QueryFailure>

    @usableFromInline
    internal typealias CapsuleForQuery<BaseQuery> = AnySimpleQueryCapsuleForQuery<BaseQuery>
    where BaseQuery: SimpleQueryProtocol, BaseQuery.QuerySuccess == QuerySuccess, BaseQuery.QueryFailure == QueryFailure

    @inlinable
    init(capsule: AnyCapsule) {
        self.capsule = capsule
    }

    @usableFromInline
    internal let capsule: AnyCapsule
}

extension AnySimpleQuery {

    @inlinable
    public init<BaseQuery>(_ baseQuery: BaseQuery)
    where BaseQuery: SimpleQueryProtocol, BaseQuery.QuerySuccess == QuerySuccess, BaseQuery.QueryFailure == QueryFailure {
        self.init(capsule: CapsuleForQuery(baseQuery))
    }

    @inlinable
    public init<BaseQuery>(_ baseQuery: BaseQuery)
    where BaseQuery: SimpleQueryProtocol, BaseQuery.QuerySuccess == QuerySuccess, QueryFailure == Error {
        self.init(capsule: CapsuleForQuery(baseQuery.mapQueryFailure { $0 as Error }))
    }
}

extension AnySimpleQuery: SimpleQueryProtocol {

    @inlinable
    public func executeQuery() -> QueryResult {
        return capsule.executeQuery()
    }
}
