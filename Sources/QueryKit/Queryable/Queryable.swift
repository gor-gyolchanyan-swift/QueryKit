//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

/// A type that can be initialized from a result of a ``Query``.
public protocol Queryable {

    // MARK: Queryable

    /* This scope is intentionally left blank. */
}

extension Queryable {

    // MARK: Queryable

    /// Creates an instance of `Self` by executing an instance of ``Query`` whose ``Query/Failure`` is `any Error`.
    ///
    /// - parameter query: The instance of ``Query`` to be executed.
    /// - throws: An instance of ``Query/Failure`` representing the error that can occur during execution `query`.
    @inlinable
    public init(query: some Query<Self, any Error>) async throws {
        switch await query.execute() {
            case .success(let success):
                self = success
            case .failure(let failure):
                throw failure
        }
    }

    /// Creates an instance of `Self` by executing an instance of ``Query`` whose ``Query/Failure`` is `Never`.
    ///
    /// - parameter query: The instance of ``Query`` to be executed.
    @inlinable
    public init(query: some Query<Self, Never>) async {
        switch await query.execute() {
            case .success(let success):
                self = success
        }
    }

    /// Creates an instance of `Self` by executing an instance of ``ImmediateQuery`` whose ``Query/Failure` is `any Error`.
    ///
    /// - parameter query: The instance of ``ImmediateQuery`` to be executed.
    /// - throws: An instance of ``Query/Failure`` representing the error that can occur during execution `query`.
    @inlinable
    public init(query: some ImmediateQuery<Self, any Error>) throws {
        switch query.execute() {
            case .success(let success):
                self = success
            case .failure(let failure):
                throw failure
        }
    }

    /// Creates an instance of `Self` by executing an instance of ``ImmediateQuery`` whose ``Query/Failure`` is `Never`.
    ///
    /// - parameter query: The instance of ``ImmediateQuery`` to be executed.
    @inlinable
    public init(query: some ImmediateQuery<Self, Never>) {
        switch query.execute() {
            case .success(let success):
                self = success
        }
    }
}
