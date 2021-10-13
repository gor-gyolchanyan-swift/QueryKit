//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

public protocol SimpleQueryProtocol: QueryProtocol {

    func executeQuery() -> QueryResult
}

extension SimpleQueryProtocol {

    @inlinable
    public func executeQuery(resultHandler: @escaping QueryResultHandler) {
        return resultHandler(executeQuery())
    }
}
