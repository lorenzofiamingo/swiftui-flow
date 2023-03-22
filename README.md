# SwiftUI Flow ➡️

A declarative and concurrent way to call views in swiftui, allowing you to pass parameters as input and return values ​​as output.

## When to resort to SwiftUI Flow

SwiftUI Flow helps showing and dismissing view in app logic. It can be used to run flows like onboardings or pickers flows, dividing declarating logic from views. Flows can also be concatenated.

## Wrappers

### `Flow`

### `FlowInput`

### `ResumeFlow`

### `CancelFlow`

## Modifiers

### `flowSheet(_: Flow, content: () -> View)`

### `flowNavigationDestination(_: Flow, content: () -> View)`

### `flowDismissDisabled(_: Bool = true)`
Use this to disable the automatic view dismiss when the flow ends. This is useful when returning from multiple flows at the same time.

## Demo
To open the demo run in the project folder `sh setup.sh` from terminal.
