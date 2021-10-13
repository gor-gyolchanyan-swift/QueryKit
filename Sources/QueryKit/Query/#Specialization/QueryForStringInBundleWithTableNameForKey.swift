//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

@frozen
public struct QueryForStringInBundleWithTableNameForKey<BundleQuery>
where BundleQuery: QueryProtocol, BundleQuery.QuerySuccess == Foundation.Bundle {

    @inlinable
    public init(bundleQuery: BundleQuery, tableName: String, stringKey: String) {
        self.bundleQuery = bundleQuery
        self.tableName = tableName
        self.stringKey = stringKey
    }

    @usableFromInline
    internal let bundleQuery: BundleQuery

    @usableFromInline
    internal let tableName: String

    @usableFromInline
    internal let stringKey: String
}

extension QueryForStringInBundleWithTableNameForKey {

    @inlinable
    internal func executeQuery(_ bundleQueryResult: BundleQuery.QueryResult) -> QueryResult {
        switch bundleQueryResult {
            case .success(let bundle):
                let stringWhereNotFound = "\u{0}"
                let string = bundle.localizedString(
                    forKey: stringKey,
                    value: stringWhereNotFound,
                    table: tableName
                )
                guard string != stringWhereNotFound else {
                    return .failure(.noStringInBundleWithTableNameForKey(bundle: bundle, tableName: tableName, stringKey: stringKey))
                }
                return .success(string)
            case .failure(let bundleQueryFailure):
                return .failure(.noBundleFromQuery(bundleQuery: bundleQuery, bundleQueryFailure: bundleQueryFailure))
        }
    }
}

extension QueryForStringInBundleWithTableNameForKey: QueryProtocol {

    public typealias QuerySuccess = String

    public enum QueryFailure: Error {

        case noBundleFromQuery(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.QueryFailure)

        case noStringInBundleWithTableNameForKey(bundle: Foundation.Bundle, tableName: String, stringKey: String)
    }

    @inlinable
    public func executeQuery(resultHandler: @escaping QueryResultHandler) {
        bundleQuery.executeQuery { bundleQueryResult in
            return resultHandler(executeQuery(bundleQueryResult))
        }
    }
}
extension QueryForStringInBundleWithTableNameForKey: SimpleQueryProtocol
where BundleQuery: SimpleQueryProtocol {


    @inlinable
    public func executeQuery() -> QueryResult {
        return executeQuery(bundleQuery.executeQuery())
    }
}
