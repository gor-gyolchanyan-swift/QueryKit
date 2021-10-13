//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

#if canImport(ObjectiveC)
    import func ObjectiveC.objc_getClass
#endif

@frozen
public struct QueryForClassForName {

    @inlinable
    public init(className: String) {
        self.className = className
    }

    @usableFromInline
    internal let className: String
}

extension QueryForClassForName: SimpleQueryProtocol {

    public typealias QuerySuccess = AnyClass

    public enum QueryFailure: Error {

        case notSupported

        case noClassForName(className: String)
    }

    @inlinable
    public func executeQuery() -> QueryResult {
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
