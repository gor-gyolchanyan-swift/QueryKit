//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

extension ImmediateQuery {

    // MARK: ImmediateQuery - Map

    /// Maps `self` to an instance of ``ImmediateQuery`` with a different ``Query/Success`` and ``Query/Failure``.
    ///
    /// - parameter doMap: The routine that can transform the ``Query/Success`` and ``Query/Failure`` of `self` into different ``Query/Success`` and ``Query/Failure`` respectively.
    /// - returns: An instance of ``ImmediateQuery`` whose ``Query/Success`` and ``Query/Failure`` are those from executing `self` and then transforming them with `doMap`.
    @inlinable
    public func map<OtherSuccess, OtherFailure>(
        _ onMap: @escaping (Result<Success, Failure>) -> Result<OtherSuccess, OtherFailure>
    ) -> some ImmediateQuery<OtherSuccess, OtherFailure>
    where OtherFailure: Error {
        MappingImmediateQuery(other: self, doMap: onMap)
    }

    /// Maps `self` to an instance of ``ImmediateQuery`` with a different ``Query/Success``.
    ///
    /// - parameter doMap: The routine that can transform the ``Query/Success`` of `self` into different ``Query/Success``.
    /// - returns: An instance of ``ImmediateQuery`` whose ``Query/Success`` is that from executing `self` and then transforming it with `doMap`.
    @inlinable
    public func mapSuccess<OtherSuccess>(
        _ onMap: @escaping (Success) -> OtherSuccess
    ) -> some ImmediateQuery<OtherSuccess, Failure> {
        map { result in
            switch result {
                case .success(let success):
                    return .success(onMap(success))
                case .failure(let failure):
                    return .failure(failure)
            }
        }
    }

    /// Maps `self` to an instance of ``ImmediateQuery`` with a different ``Query/Failure``.
    ///
    /// - parameter doMap: The routine that can transform the ``Query/Failure`` of `self` into different ``Query/Failure``.
    /// - returns: An instance of ``ImmediateQuery`` whose ``Query/Failure`` is that from executing `self` and then transforming it with `doMap`.
    @inlinable
    public func mapFailure<OtherFailure>(
        _ onMap: @escaping (Failure) -> OtherFailure
    ) -> some ImmediateQuery<Success, OtherFailure>
    where OtherFailure: Error {
        map { result in
            switch result {
                case .success(let success):
                    return .success(success)
                case .failure(let failure):
                    return .failure(onMap(failure))
            }
        }
    }

    /// Maps `self` to an instance of ``ImmediateQuery`` whose ``Query/Failure`` is `any Error`.
    ///
    /// - returns: An instance of ``ImmediateQuery`` whose ``Query/Failure`` is `any Error`.
    @inlinable
    public func mapToAnyFailure() -> some ImmediateQuery<Success, any Error> {
        mapFailure { failure in
            failure as any Error
        }
    }
}
