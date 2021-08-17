//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

public struct QueryForStringInBundleWithTableNameForKey<BundleQuery>
where BundleQuery: Query, BundleQuery.QuerySuccess == Foundation.Bundle {

    // MARK: Type: QueryForStringInBundleWithTableNameForKey

    public init(bundleQuery: BundleQuery, tableName: String, stringKey: String) {
        self.bundleQuery = bundleQuery
        self.tableName = tableName
        self.stringKey = stringKey
    }

    private var bundleQuery: BundleQuery

    private let tableName: String

    private let stringKey: String
}

extension QueryForStringInBundleWithTableNameForKey: Query {

    // MARK: Type: Query

    public typealias QuerySuccess = String

    public enum QueryFailure: Error {

        // MARK: Type: QueryForStringInBundleWithTableNameForKey.QueryFailure

        case noBundleFromQuery(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.QueryFailure)

        case noStringInBundleWithTableNameForKey(bundle: Foundation.Bundle, tableName: String, stringKey: String)
    }

    public mutating func executeQuery() -> QueryResult {
        switch bundleQuery.executeQuery() {
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
