import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    
    public func flowConfirmationDialog<Input, Output>(
        _ titleKey: LocalizedStringKey,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: @escaping () -> some View
    ) -> some View {
        flowConfirmationDialog(Text(titleKey), flow: flow, titleVisibility: titleVisibility, actions: actions)
    }
    
    public func flowConfirmationDialog<Input, Output>(
        _ title: some StringProtocol,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: @escaping () -> some View
    ) -> some View {
            flowConfirmationDialog(Text(title), flow: flow, titleVisibility: titleVisibility, actions: actions)
    }
    
    public func flowConfirmationDialog<Input, Output>(
        _ title: Text,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: @escaping () -> some View
    ) -> some View {
        modifier(FlowConfirmationDialogModifier(coordinator: flow.coordinator, title: title, titleVisibility: titleVisibility, actions: actions))
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    
    public func flowConfirmationDialog<Input, Output, T>(
        _ titleKey: LocalizedStringKey,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        presenting data: T?,
        @ViewBuilder actions: @escaping (T) -> some View
    ) -> some View {
        flowConfirmationDialog(
            Text(titleKey),
            flow: flow,
            titleVisibility: titleVisibility,
            presenting: data,
            actions: actions
        )
    }
    
    public func flowConfirmationDialog<T, Input, Output>(
        _ title: some StringProtocol,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        presenting data: T?,
        @ViewBuilder actions: @escaping (T) -> some View
    ) -> some View {
            flowConfirmationDialog(
                Text(title),
                flow: flow,
                titleVisibility: titleVisibility,
                presenting: data,
                actions: actions
            )
    }
    
    public func flowConfirmationDialog<T, Input, Output>(
        _ title: Text,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        presenting data: T?,
        @ViewBuilder actions: @escaping (T) -> some View
    ) -> some View {
        modifier(
            FlowConfirmationDialogPresentingModifier(
                coordinator: flow.coordinator,
                title: title,
                titleVisibility: titleVisibility,
                data: data,
                actions: actions
            )
        )
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    
    public func flowConfirmationDialog<Input, Output>(
        _ titleKey: LocalizedStringKey,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: @escaping () -> some View,
        @ViewBuilder message: @escaping () -> some View
    ) -> some View {
        flowConfirmationDialog(
            Text(titleKey),
            flow: flow,
            titleVisibility: titleVisibility,
            actions: actions,
            message:  message
        )
    }
    
    public func flowConfirmationDialog<Input, Output>(
        _ title: some StringProtocol,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: @escaping () -> some View,
        @ViewBuilder message: @escaping () -> some View
    ) -> some View {
            flowConfirmationDialog(
                Text(title),
                flow: flow,
                titleVisibility: titleVisibility,
                actions: actions,
                message:  message
            )
    }
    
    public func flowConfirmationDialog<Input, Output>(
        _ title: Text,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: @escaping () -> some View,
        @ViewBuilder message: @escaping () -> some View
    ) -> some View {
        modifier(
            FlowConfirmationDialogMessageModifier(
                coordinator: flow.coordinator,
                title: title,
                titleVisibility: titleVisibility,
                actions: actions,
                message: message
            )
        )
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    
    public func flowConfirmationDialog<Input, Output, T>(
        _ titleKey: LocalizedStringKey,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        presenting data: T?,
        @ViewBuilder actions: @escaping (T) -> some View,
        @ViewBuilder message: @escaping (T) -> some View
    ) -> some View {
        flowConfirmationDialog(
            Text(titleKey),
            flow: flow,
            titleVisibility: titleVisibility,
            presenting: data,
            actions: actions,
            message:  message
        )
    }
    
    public func flowConfirmationDialog<T, Input, Output>(
        _ title: some StringProtocol,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        presenting data: T?,
        @ViewBuilder actions: @escaping (T) -> some View,
        @ViewBuilder message: @escaping (T) -> some View
    ) -> some View {
            flowConfirmationDialog(
                Text(title),
                flow: flow,
                titleVisibility: titleVisibility,
                presenting: data,
                actions: actions,
                message:  message
            )
    }
    
    public func flowConfirmationDialog<T, Input, Output>(
        _ title: Text,
        flow: Flow<Input, Output>,
        titleVisibility: Visibility = .automatic,
        presenting data: T?,
        @ViewBuilder actions: @escaping (T) -> some View,
        @ViewBuilder message: @escaping (T) -> some View
    ) -> some View {
        modifier(
            FlowConfirmationDialogPresentingMessageModifier(
                coordinator: flow.coordinator,
                title: title,
                titleVisibility: titleVisibility,
                data: data,
                actions: actions,
                message: message
            )
        )
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private struct FlowConfirmationDialogModifier<Actions: View, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let title: Text
    
    private let titleVisibility: Visibility
    
    private let actions: () -> Actions
    
    init(coordinator: FlowCoordinator<Input, Output>, title: Text, titleVisibility: Visibility, actions: @escaping () -> Actions) {
        self.coordinator = coordinator
        self.title = title
        self.titleVisibility = titleVisibility
        self.actions = actions
    }

    func body(content: Content) -> some View {
        content
            .confirmationDialog(title, isPresented: $coordinator.isPresented, titleVisibility: titleVisibility) {
                actions()
                    .setupFlowContent(coordinator)
            }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private struct FlowConfirmationDialogPresentingModifier<T, Actions: View, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let title: Text
    
    private let titleVisibility: Visibility
    
    private let data: T?
    
    private let actions: (T) -> Actions
    
    init(coordinator: FlowCoordinator<Input, Output>, title: Text, titleVisibility: Visibility, data: T?, actions: @escaping (T) -> Actions) {
        self.coordinator = coordinator
        self.title = title
        self.titleVisibility = titleVisibility
        self.data = data
        self.actions = actions
    }

    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                title,
                isPresented: $coordinator.isPresented,
                titleVisibility: titleVisibility,
                presenting: data,
                actions: {
                    actions($0)
                        .setupFlowContent(coordinator)
                }
            )
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private struct FlowConfirmationDialogMessageModifier<Actions: View, Message: View, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let title: Text
    
    private let titleVisibility: Visibility
    
    private let actions: () -> Actions
    
    private let message: () -> Message
    
    init(coordinator: FlowCoordinator<Input, Output>, title: Text, titleVisibility: Visibility, actions: @escaping () -> Actions, message: @escaping () -> Message) {
        self.coordinator = coordinator
        self.title = title
        self.titleVisibility = titleVisibility
        self.actions = actions
        self.message = message
    }

    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                title,
                isPresented: $coordinator.isPresented,
                titleVisibility: titleVisibility,
                actions: {
                    actions()
                        .setupFlowContent(coordinator)
                },
                message: {
                    message()
                        .environmentObject(coordinator)
                }
            )
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private struct FlowConfirmationDialogPresentingMessageModifier<T, Actions: View, Message: View, Input, Output>: ViewModifier {
    
    @ObservedObject private var coordinator: FlowCoordinator<Input, Output>
    
    private let title: Text
    
    private let titleVisibility: Visibility
    
    private let data: T?
    
    private let actions: (T) -> Actions
    
    private let message: (T) -> Message
    
    init(coordinator: FlowCoordinator<Input, Output>, title: Text, titleVisibility: Visibility, data: T?, actions: @escaping (T) -> Actions, message: @escaping (T) -> Message) {
        self.coordinator = coordinator
        self.title = title
        self.titleVisibility = titleVisibility
        self.data = data
        self.actions = actions
        self.message = message
    }

    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                title,
                isPresented: $coordinator.isPresented,
                titleVisibility: titleVisibility,
                presenting: data,
                actions: {
                    actions($0)
                        .setupFlowContent(coordinator)
                },
                message: {
                    message($0)
                        .environmentObject(coordinator)
                }
            )
    }
}
