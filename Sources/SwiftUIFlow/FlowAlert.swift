import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    
    public func flowAlert<Input, Output>(_ titleKey: LocalizedStringKey, flow: Flow<Input, Output>, @ViewBuilder actions: @escaping () -> some View) -> some View {
        flowAlert(Text(titleKey), flow: flow, actions: actions)
    }
    
    public func flowAlert<Input, Output>(_ title: some StringProtocol, flow: Flow<Input, Output>, @ViewBuilder actions: @escaping () -> some View) -> some View {
        flowAlert(Text(title), flow: flow, actions: actions)
    }
    
    public func flowAlert<Input, Output>(_ title: Text, flow: Flow<Input, Output>, @ViewBuilder actions: @escaping () -> some View) -> some View {
        modifier(FlowAlertModifier(coordinator: flow.coordinator, title: title, actions: actions))
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    
    public func flowAlert<Input, Output>(flow: Flow<Input, Output>, error: (some LocalizedError)?, @ViewBuilder actions: @escaping () -> some View) -> some View {
        modifier(FlowAlertErrorModifier(coordinator: flow.coordinator, error: error, actions: actions))
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private struct FlowAlertModifier<Actions: View, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let actions: () -> Actions
    
    private let title: Text
    
    init(coordinator: FlowCoordinator<Input, Output>, title: Text, actions: @escaping () -> Actions) {
        self.coordinator = coordinator
        self.title = title
        self.actions = actions
    }

    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $coordinator.isPresented) {
                actions()
                    .setupFlowContent(coordinator)
            }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private struct FlowAlertErrorModifier<Actions: View, Error: LocalizedError, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let error: Error?
    
    private let actions: () -> Actions
    
    init(coordinator: FlowCoordinator<Input, Output>, error: Error?, actions: @escaping () -> Actions) {
        self.coordinator = coordinator
        self.error = error
        self.actions = actions
    }

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $coordinator.isPresented, error: error, actions: actions)
    }
}
