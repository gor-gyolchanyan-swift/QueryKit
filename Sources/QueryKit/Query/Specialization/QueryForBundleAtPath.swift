//// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

public struct QueryForBundleAtPath {

    // MARK: Type: QueryForBundleAtPath

    public init(bundlePath: String) {
        self.bundlePath = bundlePath
    }

    private let bundlePath: String
}

extension QueryForBundleAtPath: Query {

    // MARK: Type: Query

    public typealias QuerySuccess = Foundation.Bundle

    public enum QueryFailure: Error {

        // MARK: Type: QueryForBundleAtPath.QueryFailure

        case noBundleAtPath(bundlePath: String)
    }

    public mutating func executeQuery() -> QueryResult {
        guard let bundle = Foundation.Bundle(path: bundlePath) else {
            return .failure(.noBundleAtPath(bundlePath: bundlePath))
        }
        return .success(bundle)
    }
}
