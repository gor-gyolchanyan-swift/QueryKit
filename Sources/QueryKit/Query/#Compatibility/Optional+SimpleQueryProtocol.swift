//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

extension Optional: SimpleQueryProtocol {

    public typealias QuerySuccess = Wrapped

    public enum QueryFailure: Error {

        case isNil
    }

    @inlinable
    public func executeQuery() -> QueryResult {
        map(QueryResult.success(_:)) ?? .failure(.isNil)
    }
}
