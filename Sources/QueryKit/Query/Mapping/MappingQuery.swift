//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct MappingQuery<BaseQuery, QuerySuccess, QueryFailure>
where BaseQuery: QueryProtocol, QueryFailure: Error {

    @usableFromInline
    internal typealias MappingRoutine = (BaseQuery.QueryResult) -> QueryResult

    @inlinable
    internal init(_ baseQuery: BaseQuery, _ mappingRoutine: @escaping MappingRoutine) {
        self.baseQuery = baseQuery
        self.mappingRoutine = mappingRoutine
    }

    @usableFromInline
    internal let baseQuery: BaseQuery

    @usableFromInline
    internal let mappingRoutine: MappingRoutine
}
