import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
    public func flowDismissDisabled(_ isDisabled: Bool = true) -> some View {
        preference(key: FlowDismissDisabledKey.self, value: isDisabled)
    }
}

struct FlowDismissDisabledKey: PreferenceKey {
    
    static var defaultValue = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {}
}
