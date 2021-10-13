//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

public protocol QueryProtocol {

    associatedtype QuerySuccess

    associatedtype QueryFailure: Error

    typealias QueryResult = Result<QuerySuccess, QueryFailure>

    typealias QueryResultHandler = (QueryResult) -> Void

    func executeQuery(resultHandler: @escaping QueryResultHandler)
}
