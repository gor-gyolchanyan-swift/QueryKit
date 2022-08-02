//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(ObjectiveC)
    import func ObjectiveC.objc_getClass

    extension Queries {

        // MARK: Queries - ObjectiveC_Class_ForName

        @frozen
        public struct ObjectiveC_Class_ForName {

            // MARK: Queries.ObjectiveC_Class_ForName

            @inlinable
            public init(name: String) {
                self.name = name
            }

            @usableFromInline
            internal let name: String
        }
    }

    extension Queries.ObjectiveC_Class_ForName: Query {

        // MARK: Query

        public typealias Success = AnyClass

        @frozen
        public enum Failure: Error {

            // MARK: Queries.ObjectiveC_Class_ForName.Failure

            case noClassForName(name: String)
        }
    }

    extension Queries.ObjectiveC_Class_ForName: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            let maybeClass = name.withCString { name in
                ObjectiveC.objc_getClass(name)
            }
            guard let `class` = maybeClass as? AnyClass else {
                return .failure(.noClassForName(name: name))
            }
            return .success(`class`)
        }
    }

extension ImmediateQuery {

    // MARK: Queries.ObjectiveC_Class_ForName

    @inlinable
    public static func `class`(forName name: String) -> Self
    where Self == Queries.ObjectiveC_Class_ForName {
        Self(name: name)
    }
}
#endif
