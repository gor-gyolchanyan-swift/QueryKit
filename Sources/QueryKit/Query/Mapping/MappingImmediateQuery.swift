//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

@usableFromInline
internal struct MappingImmediateQuery<Other, Success, Failure>
where Other: ImmediateQuery, Failure: Error {

    // MARK: MappingQuery

    @inlinable
    internal init(
        other: Other,
        doMap: @escaping (Result<Other.Success, Other.Failure>) -> Result<Success, Failure>
    ) {
        self.other = other
        self.doMap = doMap
    }

    @usableFromInline
    internal let other: Other

    @usableFromInline
    internal let doMap: (Result<Other.Success, Other.Failure>) -> Result<Success, Failure>
}

extension MappingImmediateQuery: ImmediateQuery {

    // MARK: Query

    @inlinable
    internal func execute() -> Result<Success, Failure> {
        doMap(other.execute())
    }
}
