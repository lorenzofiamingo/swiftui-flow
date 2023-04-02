import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
final class FlowCoordinator<Input, Output>: ObservableObject {
    
    var dismissIsDisabled = false
    
    var input: Input?
    
    var resume: ((Result<Output, Error>?) -> Void)?
    
    @Published var isPresented = false {
        willSet {
            if !newValue {
                resumeSafe(nil)
            }
        }
    }
    
    func run(_ input: Input) async throws -> Output {
        guard resume == nil else {
            print("SWIFTUI FLOW MISUSE: Flow was runned again before its running continuation resumed!")
            throw CancellationError()
        }
        self.input = input
        DispatchQueue.main.async {
            self.isPresented = true
        }
        let result = await withTaskCancellationHandler {
            await withCheckedContinuation { continuation in
                resume = continuation.resume(returning:)
            }
        } onCancel: {
            resumeSafe(nil)
        }
        DispatchQueue.main.async {
            if !self.dismissIsDisabled && self.isPresented {
                self.isPresented = false
            }
        }
        try Task.checkCancellation()
        if let result {
            return try result.get()
        } else {
            throw CancellationError()
        }
    }
    
    func cancel() {
        resumeSafe(nil)
    }
    
    func dismiss() {
        resumeSafe(nil)
        DispatchQueue.main.async {
            self.isPresented = false
        }
    }
    
    func resume(with result: Result<Output, Error>) {
        resumeSafe(result)
    }
    
    func onAppear() {
        // Need to retrigger navigationDestination dismission for a bug in it. When There are two nested navigationDestination and both are dismissed at the same time (the second must have dismiss enabled) only the second is dismissed despite isPresented in the firste remains false. (Case N->N in demo)
        if !isPresented {
            isPresented = true
            DispatchQueue.main.asyncAfter(wallDeadline: .now()+0.5) {
                self.isPresented = false
            }
        }
    }
    
    func onDisappear() {
        // Need to postpone input deinitialization since navigationDestination redraw view without input while dismissing.
        if !isPresented {
            resumeSafe(nil)
            input = nil
        }
    }
    
    private func resumeSafe(_ result: Result<Output, Error>?) {
        resume?(result)
        resume = nil
    }
}
