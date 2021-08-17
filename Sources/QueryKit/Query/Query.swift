//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

public protocol Query {

    // MARK: Type: Query

    associatedtype QuerySuccess

    associatedtype QueryFailure: Error

    typealias QueryResult = Result<QuerySuccess, QueryFailure>

    mutating func executeQuery() -> QueryResult
}
