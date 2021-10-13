//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

extension MappingQuery: SimpleQueryProtocol
where BaseQuery: SimpleQueryProtocol {

    @inlinable
    public func executeQuery() -> QueryResult {
        let baseQueryResult = baseQuery.executeQuery()
        return mappingRoutine(baseQueryResult)
    }
}
