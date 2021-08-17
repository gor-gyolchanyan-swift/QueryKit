//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

#if canImport(ObjectiveC)
    import func ObjectiveC.objc_getClass
#endif

public struct QueryForClassForName {

    // MARK: Type: QueryForClassForName

    public init(className: String) {
        self.className = className
    }

    private let className: String
}

extension QueryForClassForName: Query {

    // MARK: Type: Query

    public typealias QuerySuccess = AnyClass

    public enum QueryFailure: Error {

        // MARK: Type: QueryForClassForName.QueryFailure

        case notSupported

        case noClassForName(className: String)
    }

    public mutating func executeQuery() -> QueryResult {
        #if canImport(ObjectiveC)
            let maybeClass = className.withCString { className in
                ObjectiveC.objc_getClass(className)
            }
            guard let `class` = maybeClass as? AnyClass else {
                return .failure(.noClassForName(className: className))
            }
            return .success(`class`)
        #else
            return .failure(.notSupported)
        #endif
    }
}
