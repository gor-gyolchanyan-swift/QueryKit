//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

extension Query {

    // MARK: Type: Query, Topic: Mapping

    public func mapQueryResult<OtherQuerySuccess, OtherQueryFailure>(
        _ mappingRoutine: @escaping (QueryResult) -> Result<OtherQuerySuccess, OtherQueryFailure>
    ) -> MappingQuery<Self, OtherQuerySuccess, OtherQueryFailure>
    where OtherQueryFailure: Error {
        return MappingQuery(self, mappingRoutine)
    }

    public func mapQuerySuccess<OtherQuerySuccess>(
        mappingRoutine: @escaping (QuerySuccess) -> OtherQuerySuccess
    ) -> MappingQuery<Self, OtherQuerySuccess, QueryFailure> {
        mapQueryResult { queryResult in
            queryResult.map(mappingRoutine)
        }
    }

    public func mapQueryFailure<OtherQueryFailure>(
        mappingRoutine: @escaping (QueryFailure) -> OtherQueryFailure
    ) -> MappingQuery<Self, QuerySuccess, OtherQueryFailure> {
        mapQueryResult { queryResult in
            queryResult.mapError(mappingRoutine)
        }
    }

    public func flatMapQuerySuccess<OtherQuerySuccess>(
        mappingRoutine: @escaping (QuerySuccess) -> Result<OtherQuerySuccess, QueryFailure>
    ) -> MappingQuery<Self, OtherQuerySuccess, QueryFailure> {
        mapQueryResult { queryResult in
            queryResult.flatMap(mappingRoutine)
        }
    }

    public func flatMapQueryFailure<OtherQueryFailure>(
        mappingRoutine: @escaping (QueryFailure) -> Result<QuerySuccess, OtherQueryFailure>
    ) -> MappingQuery<Self, QuerySuccess, OtherQueryFailure> {
        mapQueryResult { queryResult in
            queryResult.flatMapError(mappingRoutine)
        }
    }
}

public struct MappingQuery<BaseQuery, QuerySuccess, QueryFailure>
where BaseQuery: Query, QueryFailure: Error {

    // MARK: Type: MappingQuery

    fileprivate init(
        _ baseQuery: BaseQuery,
        _ mappingRoutine: @escaping (BaseQuery.QueryResult) -> QueryResult
    ) {
        self.baseQuery = baseQuery
        self.mappingRoutine = mappingRoutine
    }

    private var baseQuery: BaseQuery

    private let mappingRoutine: (BaseQuery.QueryResult) -> QueryResult
}

extension MappingQuery: Query {

    // MARK: Type: Query

    public typealias QueryResult = Result<QuerySuccess, QueryFailure>

    public mutating func executeQuery() -> QueryResult {
        mappingRoutine(baseQuery.executeQuery())
    }
}
