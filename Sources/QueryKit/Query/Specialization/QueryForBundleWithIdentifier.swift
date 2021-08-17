//// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

public struct QueryForBundleWithIdentifier {

    // MARK: Type: QueryForBundleWithIdentifier

    public init(bundleIdentifier: String) {
        self.bundleIdentifier = bundleIdentifier
    }

    private let bundleIdentifier: String
}

extension QueryForBundleWithIdentifier: Query {

    // MARK: Type: Query

    public typealias QuerySuccess = Foundation.Bundle

    public enum QueryFailure: Error {

        // MARK: Type: QueryForBundleWithIdentifier.QueryFailure

        case noBundleWithIdentifier(bundleIdentifier: String)
    }

    public mutating func executeQuery() -> QueryResult {
        guard let bundle = Foundation.Bundle(identifier: bundleIdentifier) else {
            return .failure(.noBundleWithIdentifier(bundleIdentifier: bundleIdentifier))
        }
        return .success(bundle)
    }
}
