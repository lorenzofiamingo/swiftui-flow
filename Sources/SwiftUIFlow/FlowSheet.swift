import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
    public func flowSheet<Input, Output>(_ flow: Flow<Input, Output>, @ViewBuilder content: @escaping () -> some View) -> some View {
        modifier(FlowSheetModifier(coordinator: flow.coordinator, flowContent: content))
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct FlowSheetModifier<FlowContent: View, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let flowContent: () -> FlowContent
    
    init(coordinator: FlowCoordinator<Input, Output>, flowContent: @escaping () -> FlowContent) {
        self.coordinator = coordinator
        self.flowContent = flowContent
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $coordinator.isPresented, onDismiss: coordinator.cancel) {
                flowContent()
                    .setupFlowContent(coordinator)
            }
    }
}
