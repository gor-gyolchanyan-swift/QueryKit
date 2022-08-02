//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICEUIE` file located at the root of the repository that contains this file.
//

// TODO: Document the content of this file.

#if canImport(UIKit)
    import class UIKit.UIImage

    extension Queries {

        // MARK: Queries - UIKit_UIImage_ForSystemName

        @frozen
        public struct UIKit_UIImage_ForSystemName {

            // MARK: Queries.UIKit_UIImage_ForSystemName

            @inlinable
            public init(systemName: String) {
                self.systemName = systemName
            }

            @usableFromInline
            internal let systemName: String
        }
    }

    extension Queries.UIKit_UIImage_ForSystemName: ImmediateQuery {

        // MARK: Query

        public typealias Success = UIKit.UIImage

        @frozen
        public enum Failure: Error {

            // MARK: Queries.UIKit_UIImage_ForSystemName.Failure

            case noImageForSystemName(systemName: String)
        }

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            guard let image = UIKit.UIImage(systemName: systemName) else {
                return .failure(.noImageForSystemName(systemName: systemName))
            }
            return .success(image)
        }
    }

    extension Query {

        // MARK: Queries.UIKit_UIImage_ForSystemName

        @inlinable
        public static func image(forSystemName systemName: String) -> Self
        where Self == Queries.UIKit_UIImage_ForSystemName {
            Self(systemName: systemName)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.UIKit_UIImage_ForSystemName

        @inlinable
        public static func image(forSystemName systemName: String) -> Self
        where Self == Queries.UIKit_UIImage_ForSystemName {
            Self(systemName: systemName)
        }
    }
#endif
