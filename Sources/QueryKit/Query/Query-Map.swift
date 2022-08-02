//
// Introductory information is in the `README.md` file in the root directory of the repository this file is in.
// Licensing information is in the `LICENSE.txt` file in the root directory of the repository this file is in.
//

extension Query {

    // MARK: Query - Map

    /// Maps `self` to an instance of ``Query`` with a different ``Query/Success`` and ``Query/Failure``.
    ///
    /// - parameter doMap: The routine that can transform the ``Query/Success`` and ``Query/Failure`` of `self` into different ``Query/Success`` and ``Query/Failure`` respectively.
    /// - returns: An instance of ``Query`` whose ``Query/Success`` and ``Query/Failure`` are those from executing `self` and then transforming them with `doMap`.
    @inlinable
    public func map<OtherSuccess, OtherFailure>(
        _ doMap: @escaping (Result<Success, Failure>) async -> Result<OtherSuccess, OtherFailure>
    ) -> some Query<OtherSuccess, OtherFailure>
    where OtherFailure: Error {
        MappingQuery(other: self, doMap: doMap)
    }

    /// Maps `self` to an instance of ``Query`` with a different ``Query/Success``.
    ///
    /// - parameter doMap: The routine that can transform the ``Query/Success`` of `self` into different ``Query/Success``.
    /// - returns: An instance of ``Query`` whose ``Query/Success`` is that from executing `self` and then transforming it with `doMap`.
    @inlinable
    public func mapSuccess<OtherSuccess>(
        _ doMap: @escaping (Success) async -> OtherSuccess
    ) -> some Query<OtherSuccess, Failure> {
        map { result in
            switch result {
                case .success(let success):
                    return .success(await doMap(success))
                case .failure(let failure):
                    return .failure(failure)
            }
        }
    }

    /// Maps `self` to an instance of ``Query`` with a different ``Query/Failure``.
    ///
    /// - parameter doMap: The routine that can transform the ``Query/Failure`` of `self` into different ``Query/Failure``.
    /// - returns: An instance of ``Query`` whose ``Query/Failure`` is that from executing `self` and then transforming it with `doMap`.
    @inlinable
    public func mapFailure<OtherFailure>(
        _ doMap: @escaping (Failure) async -> OtherFailure
    ) -> some Query<Success, OtherFailure>
    where OtherFailure: Error {
        map { result in
            switch result {
                case .success(let success):
                    return .success(success)
                case .failure(let failure):
                    return await .failure(doMap(failure))
            }
        }
    }

    /// Maps `self` to an instance of ``Query`` whose ``Query/Failure`` is `any Error`.
    ///
    /// - returns: An instance of ``Query`` whose ``Query/Failure`` is `any Error`.
    @inlinable
    public func mapToAnyFailure() -> some Query<Success, any Error> {
        mapFailure { failure in
            failure as any Error
        }
    }
}
