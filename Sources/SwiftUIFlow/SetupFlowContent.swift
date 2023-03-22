import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
    func setupFlowContent<Input, Output>(_ coordinator: FlowCoordinator<Input, Output>) -> some View {
        modifier(SetupFlowCoordinatorModifier(coordinator: coordinator))
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct SetupFlowCoordinatorModifier<Input, Output>: ViewModifier {
    
    private let coordinator: FlowCoordinator<Input, Output>
    
    init(coordinator: FlowCoordinator<Input, Output>) {
        self.coordinator = coordinator
    }
    
    func body(content: Content) -> some View {
        content
            .environmentObject(coordinator)
            .onAppear(perform: coordinator.onAppear)
            .onDisappear(perform: coordinator.onDisappear)
            .onPreferenceChange(FlowDismissDisabledKey.self) { isDisabled in
                coordinator.dismissIsDisabled = isDisabled
            }
    }
}
