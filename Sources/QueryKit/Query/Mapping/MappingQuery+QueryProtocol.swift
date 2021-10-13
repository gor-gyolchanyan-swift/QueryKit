//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

extension MappingQuery: QueryProtocol {

    public typealias QueryResult = Result<QuerySuccess, QueryFailure>

    public typealias QueryResultHandler = (QueryResult) -> Void

    @inlinable
    public func executeQuery(resultHandler: @escaping QueryResultHandler) {
        baseQuery.executeQuery { baseQueryResult in
            let queryResult = mappingRoutine(baseQueryResult)
            return resultHandler(queryResult)
        }
    }
}
