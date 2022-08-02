//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

/// A type that can run asynchronous operations attempting to obtain values of a specific type with a possibility of a specific type of error occurring.
public protocol Query<Success, Failure> {

    // MARK: Query

    /// The type of value that can be obtained by a successful execution of an instance of `Self`.
    associatedtype Success

    /// The type of error that can occur during execution of an instance of `Self`.
    associatedtype Failure: Error

    /// Executes `self`.
    ///
    /// - returns: An instance of `Result` indicating the result of the execution.
    func execute() async -> Result<Success, Failure>
}

extension Query {

    // MARK: Query

    /// Executes `self`, whose ``Query/Failure`` is `any Error`.
    ///
    /// - returns: An instance of ``Query/Success`` representing the value obtaned from the execution of `self`.
    /// - throws: An instance of ``Query/Failure`` representing the error that can occur during the execution of `self`.
    @inlinable
    public func execute() async throws -> Success
    where Failure == any Error {
        switch await execute() as Result<Success, Failure> {
            case .success(let success):
                return success
            case .failure(let failure):
                throw failure
        }
    }

    /// Executes `self`, whose ``Query/Failure`` is `Never`.
    ///
    /// - returns: An instance of ``Query/Success`` representing the value obtaned from the execution of `self`.
    @inlinable
    public func execute() async -> Success
    where Failure == Never {
        switch await execute() as Result<Success, Failure> {
            case .success(let success):
                return success
        }
    }
}
