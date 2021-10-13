//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

extension QueryProtocol {

    @inlinable
    public func mapQueryResult<OtherQuerySuccess, OtherQueryFailure>(
        mappingRoutine: @escaping (QueryResult) -> Result<OtherQuerySuccess, OtherQueryFailure>
    ) -> MappingQuery<Self, OtherQuerySuccess, OtherQueryFailure> where
        OtherQueryFailure: Error
    {
        return MappingQuery(self, mappingRoutine)
    }

    @inlinable
    public func mapQuerySuccess<OtherQuerySuccess>(
        _ mappingRoutine: @escaping (QuerySuccess) -> OtherQuerySuccess
    ) -> MappingQuery<Self, OtherQuerySuccess, QueryFailure> {
        return mapQueryResult { queryResult in
            return queryResult.map(mappingRoutine)
        }
    }

    @inlinable
    public func mapQueryFailure<OtherQueryFailure>(
        _ mappingRoutine: @escaping (QueryFailure) -> OtherQueryFailure
    ) -> MappingQuery<Self, QuerySuccess, OtherQueryFailure> where
        OtherQueryFailure: Error
    {
        return mapQueryResult { queryResult in
            return queryResult.mapError(mappingRoutine)
        }
    }

    @inlinable
    public func flatMapQuerySuccess<OtherQuerySuccess>(
        _ mappingRoutine: @escaping (QuerySuccess) -> Result<OtherQuerySuccess, QueryFailure>
    ) -> MappingQuery<Self, OtherQuerySuccess, QueryFailure> {
        return mapQueryResult { queryResult in
            return queryResult.flatMap(mappingRoutine)
        }
    }

    @inlinable
    public func flatMapQueryFailure<OtherQueryFailure>(
        _ mappingRoutine: @escaping (QueryFailure) -> Result<QuerySuccess, OtherQueryFailure>
    ) -> MappingQuery<Self, QuerySuccess, OtherQueryFailure> where
        OtherQueryFailure: Error
    {
        return mapQueryResult { queryResult in
            return queryResult.flatMapError(mappingRoutine)
        }
    }
}
