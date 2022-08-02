//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(AppKit)
    import class AppKit.NSImage

    extension Queries {

        // MARK: Queries - AppKit_NSImage_AtPath

        @frozen
        public struct AppKit_NSImage_AtPath {

            /// MARK: Queries.AppKit_NSImage_AtPath

            @inlinable
            public init(path: String) {
                self.path = path
            }

            @usableFromInline
            internal let path: String
        }
    }

    extension Queries.AppKit_NSImage_AtPath: ImmediateQuery {

        // MARK: ImmediateQuery

        public typealias Success = AppKit.NSImage

        @frozen
        public enum Failure: Error {

            // MARK: Queries.AppKit_NSImage_AtPath.Failure

            case noImageAtPath(path: String)
        }

        @inlinable
        public func execute() -> Result<Success, Failure> {
            guard let image = AppKit.NSImage(contentsOfFile: path) else {
                return .failure(.noImageAtPath(path: path))
            }
            return .success(image)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.AppKit_NSImage_AtPath

        @inlinable
        public static func image(atPath path: String) -> Self
        where Self == Queries.AppKit_NSImage_AtPath {
            Self(path: path)
        }
    }
#endif
