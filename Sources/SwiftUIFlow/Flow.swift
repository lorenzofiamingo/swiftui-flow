import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct Flow<Input, Output>: DynamicProperty {
    
    @State private var store: Store?
    
    private let bindedCoordinator: FlowCoordinator<Input, Output>?
    
    public var wrappedValue: (Input) async throws -> Output {
        { try await coordinator.run($0) }
    }
    
    public var projectedValue: Flow<Input, Output> {
        Flow(coordinator: coordinator)
    }
    
    public var input: Input {
        guard let input = coordinator.input else {
            fatalError("No input of the flow was found. The flow should be running to read the input.")
        }
        return input
    }
    
    var coordinator: FlowCoordinator<Input, Output> {
        store?.coordinator ?? bindedCoordinator!
    }
    
    public init() {
        store = Store()
        bindedCoordinator = nil
    }
    
    init(coordinator: FlowCoordinator<Input, Output>) {
        bindedCoordinator = coordinator
    }
    
    public func resume(with result: Result<Output, Error>) {
        coordinator.resume(with: result)
    }
    
    public func resume(returning output: Output) {
        coordinator.resume(with: .success(output))
    }
    
    public func resume(throwing error: Error) {
        coordinator.resume(with: .failure(error))
    }
    
    public func cancel() {
        coordinator.cancel()
    }
    
    public func dismiss() {
        coordinator.dismiss()
    }
    
    private struct Store {
        let coordinator = FlowCoordinator<Input, Output>()
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Flow where Input == Void {
    
    public var wrappedValue: () async throws -> Output {
        { try await coordinator.run(()) }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct FlowInput<Input, Output>: DynamicProperty {
    
    @EnvironmentObject private var coordinator: FlowCoordinator<Input, Output>
    
    public var wrappedValue: Input {
        guard let input = coordinator.input else {
            fatalError("No input of the flow was found. The flow should be running to read the input.")
        }
        return input
    }
    
    public var projectedValue: Flow<Input, Output> {
        Flow(coordinator: coordinator)
    }
    
    public init() {}
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct ResumeFlow<Input, Output>: DynamicProperty {
    
    @EnvironmentObject private var coordinator: FlowCoordinator<Input, Output>
    
    public var wrappedValue: (Output) -> Void {
        { coordinator.resume(with: .success($0)) }
    }
    
    public var projectedValue: Flow<Input, Output> {
        Flow(coordinator: coordinator)
    }
    
    public init() {}
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct CancelFlow<Input, Output>: DynamicProperty {
    
    @EnvironmentObject private var coordinator: FlowCoordinator<Input, Output>
    
    public var wrappedValue: () -> Void {
        { coordinator.cancel() }
    }
    
    public var projectedValue: Flow<Input, Output> {
        Flow(coordinator: coordinator)
    }
    
    public init() {}
}
