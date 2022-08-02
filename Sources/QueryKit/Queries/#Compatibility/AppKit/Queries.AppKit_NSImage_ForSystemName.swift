//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(AppKit)
    import class AppKit.NSImage

    extension Queries {

        // MARK: Queries - AppKit_NSImage_ForSystemName

        @frozen
        public struct AppKit_NSImage_ForSystemName {

            // MARK: Queries.AppKit_NSImage_ForSystemName

            @inlinable
            public init(systemName: String) {
                self.systemName = systemName
            }

            @usableFromInline
            internal let systemName: String
        }
    }

    extension Queries.AppKit_NSImage_ForSystemName: ImmediateQuery {

        // MARK: Query

        public typealias Success = AppKit.NSImage

        @frozen
        public enum Failure: Error {

            // MARK: Queries.AppKit_NSImage_ForSystemName.Failure

            case noImageForSystemName(systemName: String)
        }

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            if #available(macOS 11.0, *) {
                guard let image = AppKit.NSImage(systemSymbolName: systemName, accessibilityDescription: nil) else {
                    return .failure(.noImageForSystemName(systemName: systemName))
                }
                return .success(image)
            } else {
                return .success(AppKit.NSImage())
            }
        }
    }

    extension Query {

        // MARK: Queries.AppKit_NSImage_ForSystemName

        @inlinable
        public static func image(forSystemName systemName: String) -> Self
        where Self == Queries.AppKit_NSImage_ForSystemName {
            Self(systemName: systemName)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.AppKit_NSImage_ForSystemName

        @inlinable
        public static func image(forSystemName systemName: String) -> Self
        where Self == Queries.AppKit_NSImage_ForSystemName {
            Self(systemName: systemName)
        }
    }
#endif
