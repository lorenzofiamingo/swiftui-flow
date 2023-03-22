import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension View {
    
    public func flowNavigationDestination<Input, Output>(_ flow: Flow<Input, Output>, @ViewBuilder content: @escaping () -> some View) -> some View {
        modifier(FlowNavigationDestinationModifier(coordinator: flow.coordinator, flowContent: content))
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private struct FlowNavigationDestinationModifier<FlowContent: View, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let flowContent: () -> FlowContent
    
    init(coordinator: FlowCoordinator<Input, Output>, flowContent: @escaping () -> FlowContent) {
        self.coordinator = coordinator
        self.flowContent = flowContent
    }
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(isPresented: $coordinator.isPresented) {
                if coordinator.input != nil {
                    flowContent()
                        .setupFlowContent(coordinator)
                }
            }
    }
}
