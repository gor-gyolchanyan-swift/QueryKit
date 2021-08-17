//// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

public struct QueryForBundleForClass<ClassQuery>
where ClassQuery: Query, ClassQuery.QuerySuccess == AnyClass {

    // MARK: Type: QueryForBundleForClass

    public init(classQuery: ClassQuery) {
        self.classQuery = classQuery
    }

    private var classQuery: ClassQuery
}

extension QueryForBundleForClass: Query {

    // MARK: Type: Query

    public typealias QuerySuccess = Foundation.Bundle

    public enum QueryFailure: Error {

        // MARK: Type: QueryForBundleForClass.QueryFailure

        case classQueryFailure(classQuery: ClassQuery, classQueryFailure: ClassQuery.QueryFailure)
    }

    public mutating func executeQuery() -> QueryResult {
        switch classQuery.executeQuery() {
            case .success(let `class`):
                let bundle = Foundation.Bundle(for: `class`)
                return .success(bundle)
            case .failure(let classQueryFailure):
                return .failure(.classQueryFailure(classQuery: classQuery, classQueryFailure: classQueryFailure))
        }
    }
}
