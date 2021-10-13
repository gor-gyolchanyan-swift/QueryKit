// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

@frozen
public struct QueryForBundleForClass<ClassQuery>
where ClassQuery: QueryProtocol, ClassQuery.QuerySuccess == AnyClass {

    @inlinable
    public init(classQuery: ClassQuery) {
        self.classQuery = classQuery
    }

    @usableFromInline
    internal let classQuery: ClassQuery
}

extension QueryForBundleForClass {

    @inlinable
    internal func executeQuery(_ classQueryResult: ClassQuery.QueryResult) -> QueryResult {
        switch classQueryResult {
            case .success(let `class`):
                let bundle = Foundation.Bundle(for: `class`)
                return .success(bundle)
            case .failure(let classQueryFailure):
                return .failure(.classQueryFailure(classQuery: classQuery, classQueryFailure: classQueryFailure))
        }
    }
}

extension QueryForBundleForClass: QueryProtocol {

    public typealias QuerySuccess = Foundation.Bundle

    public enum QueryFailure: Error {

        case classQueryFailure(classQuery: ClassQuery, classQueryFailure: ClassQuery.QueryFailure)
    }

    @inlinable
    public func executeQuery(resultHandler: @escaping QueryResultHandler) {
        classQuery.executeQuery { classQueryResult in
            return resultHandler(executeQuery(classQueryResult))
        }
    }
}

extension QueryForBundleForClass: SimpleQueryProtocol
where ClassQuery: SimpleQueryProtocol {

    @inlinable
    public func executeQuery() -> QueryResult {
        return executeQuery(classQuery.executeQuery())
    }
}
