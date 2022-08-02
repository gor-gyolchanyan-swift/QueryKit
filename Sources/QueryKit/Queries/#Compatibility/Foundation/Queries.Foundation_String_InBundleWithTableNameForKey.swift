//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

// TODO: Document the content of this file.

#if canImport(Foundation)
    import class Foundation.Bundle

    extension Queries {

        // MARK: Queries - Foundation_String_InBundleWithTableNameForKey

        @frozen
        public struct Foundation_String_InBundleWithTableNameForKey<BundleQuery>
        where BundleQuery: Query, BundleQuery.Success == Foundation.Bundle {

            // MARK: Queries.Foundation_String_InBundleWithTableNameForKey

            @inlinable
            public init(bundleQuery: BundleQuery, tableName: String, key: String) {
                self.bundleQuery = bundleQuery
                self.tableName = tableName
                self.key = key
            }

            @usableFromInline
            internal let bundleQuery: BundleQuery

            @usableFromInline
            internal let tableName: String

            @usableFromInline
            internal let key: String
        }
    }

    extension Queries.Foundation_String_InBundleWithTableNameForKey {

        // MARK: Queries.Foundation_String_InBundleWithTableNameForKey

        @inlinable
        internal func execute(_ bundleQueryResult: Result<BundleQuery.Success, BundleQuery.Failure>) -> Result<Success, Failure> {
            switch bundleQueryResult {
                case .success(let bundle):
                    // We've chosen a single `NUL` character as an indicator of a missing string localization,
                    // because an empty string is a valid localization of a string.
                    let missingString = "\u{0}"
                    let string = bundle.localizedString(
                        forKey: key,
                        value: missingString,
                        table: tableName
                    )
                    guard string != missingString else {
                        return .failure(.noStringInBundleWithTableNameForKey(bundle: bundle, tableName: tableName, key: key))
                    }
                    return .success(string)
                case .failure(let bundleQueryFailure):
                    return .failure(.bundleQueryFailure(bundleQuery: bundleQuery, bundleQueryFailure: bundleQueryFailure))
            }
        }
    }

    extension Queries.Foundation_String_InBundleWithTableNameForKey: Query {

        // MARK: Query

        public typealias Success = String

        @frozen
        public enum Failure: Error {

            case bundleQueryFailure(bundleQuery: BundleQuery, bundleQueryFailure: BundleQuery.Failure)

            case noStringInBundleWithTableNameForKey(bundle: Foundation.Bundle, tableName: String, key: String)
        }

        @inlinable
        public func execute() async -> Result<Success, Failure> {
            execute(await bundleQuery.execute())
        }
    }

    extension Queries.Foundation_String_InBundleWithTableNameForKey: ImmediateQuery
    where BundleQuery: ImmediateQuery {

        // MARK: ImmediateQuery

        @inlinable
        public func execute() -> Result<Success, Failure> {
            return execute(bundleQuery.execute())
        }
    }

    extension Query {

        // MARK: Queries.Foundation_String_InBundleWithTableNameForKey

        @inlinable
        public static func string<BundleQuery>(inBundle bundleQuery: BundleQuery, withTableName tableName: String, forKey key: String) -> Self
        where Self == Queries.Foundation_String_InBundleWithTableNameForKey<BundleQuery> {
            Self(bundleQuery: bundleQuery, tableName: tableName, key: key)
        }
    }

    extension ImmediateQuery {

        // MARK: Queries.Foundation_String_InBundleWithTableNameForKey

        @inlinable
        public static func string<BundleQuery>(inBundle bundleQuery: BundleQuery, withTableName tableName: String, forKey key: String) -> Self
        where Self == Queries.Foundation_String_InBundleWithTableNameForKey<BundleQuery> {
            Self(bundleQuery: bundleQuery, tableName: tableName, key: key)
        }
    }
#endif
