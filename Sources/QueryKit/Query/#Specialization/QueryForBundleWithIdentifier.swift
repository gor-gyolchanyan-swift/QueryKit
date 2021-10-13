// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

@frozen
public struct QueryForBundleWithIdentifier {

    @inlinable
    public init(bundleIdentifier: String) {
        self.bundleIdentifier = bundleIdentifier
    }

    @usableFromInline
    internal let bundleIdentifier: String
}

extension QueryForBundleWithIdentifier: SimpleQueryProtocol {

    public typealias QuerySuccess = Foundation.Bundle

    public enum QueryFailure: Error {

        case noBundleWithIdentifier(bundleIdentifier: String)
    }

    @inlinable
    public func executeQuery() -> QueryResult {
        guard let bundle = Foundation.Bundle(identifier: bundleIdentifier) else {
            return .failure(.noBundleWithIdentifier(bundleIdentifier: bundleIdentifier))
        }
        return .success(bundle)
    }
}
