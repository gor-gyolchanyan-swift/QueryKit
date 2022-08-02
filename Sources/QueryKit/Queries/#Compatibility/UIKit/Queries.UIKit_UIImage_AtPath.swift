//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICEUIE` file located at the root of the repository that contains this file.
//

// TODO: Document the content of this file.

#if canImport(UIKit)
    import class UIKit.UIImage

    extension Queries {

        // MARK: Queries - UIKit_UIImage_AtPath

        @frozen
        public struct UIKit_UIImage_AtPath {

            /// MARK: Queries.UIKit_UIImage_AtPath

            @inlinable
            public init(path: String) {
                self.path = path
            }

            @usableFromInline
            internal let path: String
        }
    }

    extension Queries.UIKit_UIImage_AtPath: ImmediateQuery {

        // MARK: ImmediateQuery

        public typealias Success = UIKit.UIImage

        @frozen
        public enum Failure: Error {

            // MARK: Queries.UIKit_UIImage_AtPath.Failure

            case noImageAtPath(path: String)
        }

        @inlinable
        public func execute() -> Result<Success, Failure> {
            guard let image = UIKit.UIImage(contentsOfFile: imagePath) else {
                return .failure(.noImageAtPath(imagePath: imagePath))
            }
            return .success(image)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.UIKit_UIImage_AtPath

        @inlinable
        public static func image(atPath path: String) -> Self
        where Self == Queries.UIKit_UIImage_AtPath {
            Self(path: path)
        }
    }
#endif
