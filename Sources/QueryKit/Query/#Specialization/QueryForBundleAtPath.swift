// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import class Foundation.Bundle

@frozen
public struct QueryForBundleAtPath {

    @inlinable
    public init(bundlePath: String) {
        self.bundlePath = bundlePath
    }

    @usableFromInline
    internal let bundlePath: String
}

extension QueryForBundleAtPath: SimpleQueryProtocol {

    public typealias QuerySuccess = Foundation.Bundle

    public enum QueryFailure: Error {

        case noBundleAtPath(bundlePath: String)
    }

    @inlinable
    public func executeQuery() -> QueryResult {
        guard let bundle = Foundation.Bundle(path: bundlePath) else {
            return .failure(.noBundleAtPath(bundlePath: bundlePath))
        }
        return .success(bundle)
    }
}
