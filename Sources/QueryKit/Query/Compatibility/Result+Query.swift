//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

extension Result: Query {

    // MARK: Type: Query

    public typealias QuerySuccess = Success

    public enum QueryFailure: Error {

        // MARK: Type: Result.QueryFailure

        case isFailure(_ failure: Failure)
    }

    public func executeQuery() -> QueryResult {
        self.mapError(QueryFailure.isFailure(_:))
    }
}
