//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

/// A type that can run synchronous operations attempting to obtain values of a specific type with a possibility of a specific type of error occurring.
public protocol ImmediateQuery<Success, Failure>: Query {

    // MARK: ImmediateQuery

    /// Executes `self`.
    ///
    /// - returns: An instance of `Result` indicating the result of the execution.
    func execute() -> Result<Success, Failure>
}

extension ImmediateQuery {

    // MARK: ImmediateQuery

    /// Executes `self`, whose ``Query/Failure`` is `any Error`.
    ///
    /// - returns: An instance of ``Query/Success`` representing the value obtaned from the execution of `self`.
    /// - throws: An instance of ``Query/Failure`` representing the error that can occur during the execution of `self`.
    @inlinable
    public func execute() throws -> Success
    where Failure == any Error {
        switch execute() as Result<Success, Failure> {
            case .success(let query):
                return query
            case .failure(let query):
                throw query
        }
    }

    /// Executes `self`, whose ``Query/Failure`` is `Never`.
    ///
    /// - returns: An instance of ``Query/Success`` representing the value obtaned from the execution of `self`.
    @inlinable
    public func execute() -> Success
    where Failure == Never {
        switch execute() as Result<Success, Failure> {
            case .success(let query):
                return query
        }
    }
}
