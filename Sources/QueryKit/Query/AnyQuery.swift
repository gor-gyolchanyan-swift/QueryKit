//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

public struct AnyQuery<QuerySuccess, QueryFailure>
where QueryFailure: Error {

    // MARK: Type: AnyQuery, Topic: Object

    private typealias Object = AnyQueryObject<QuerySuccess, QueryFailure>

    private typealias ObjectForQuery<QueryType> = AnyQueryObjectForQuery<QueryType>
    where QueryType: Query, QueryType.QuerySuccess == QuerySuccess, QueryType.QueryFailure == QueryFailure

    private init(object: Object) {
        self.object = object
    }

    private var object: Object
}

extension AnyQuery {

    // MARK: Type: AnyQuery

    public init<QueryType>(_ query: QueryType)
    where QueryType: Query, QueryType.QuerySuccess == QuerySuccess, QueryType.QueryFailure == QueryFailure {
        self.init(object: ObjectForQuery(query))
    }

    private mutating func prepareToMutate() {
        if !isKnownUniquelyReferenced(&object) {
            object = object.clone()
        }
    }
}

extension AnyQuery: Query {

    // MARK: Type: Query

    public typealias QueryResult = Result<QuerySuccess, QueryFailure>

    public mutating func executeQuery() -> QueryResult {
        prepareToMutate()
        return object.executeQuery()
    }
}

fileprivate class AnyQueryObject<QuerySuccess, QueryFailure>: Query
where QueryFailure: Error {

    // MARK: Type: AnyQueryObject

    fileprivate typealias Object = AnyQueryObject<QuerySuccess, QueryFailure>

    fileprivate func clone() -> Object {
        preconditionFailure("execution has reached a routine that should have been overridden")
    }

    // MARK: Type: Query

    fileprivate func executeQuery() -> QueryResult {
        preconditionFailure("execution has reached a routine that should have been overridden")
    }
}

fileprivate class AnyQueryObjectForQuery<QueryType>: AnyQueryObject<QueryType.QuerySuccess, QueryType.QueryFailure>
where QueryType: Query {

    // MARK: Type: AnyQueryObjectForQuery

    fileprivate init(_ query: QueryType) {
        self.query = query
    }

    private var query: QueryType

    // MARK: Type: AnyQueryObject

    fileprivate override func clone() -> Object {
        AnyQueryObjectForQuery(query)
    }

    // MARK: Type: Query

    fileprivate override func executeQuery() -> QueryResult {
        query.executeQuery()
    }
}
