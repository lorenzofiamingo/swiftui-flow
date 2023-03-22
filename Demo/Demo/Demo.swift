//
// SwiftUIFlow Demo
//

import SwiftUI
import SwiftUIFlow

struct Demo: View {
    
    @State private var emoji1 = "❓"
    @Flow<[String], String> private var pickEmoji1
    
    @State private var emoji2 = "❓"
    @Flow<[String], String> private var pickEmoji2
    
    @State private var emoji3 = "❓"
    @Flow<[String], String> private var pickEmoji3
    
    @State private var emoji4 = "❓"
    @Flow<[String], String> private var pickEmoji4
    
    @State private var emoji5 = "❓"
    @Flow<[String], String> private var pickEmoji5
    
    @State private var emoji6 = "❓"
    @Flow<[String], String> private var pickEmoji6
    
    @State private var emoji7 = "❓"
    @Flow<[String], String> private var pickEmoji7
    
    @State private var emoji8 = "❓"
    @Flow<[String], String> private var pickEmoji8
    
    @State private var emoji9 = "❓"
    @Flow<[String], String> private var pickEmoji9
    
    @State private var emoji10 = "❓"
    @Flow<[String], String> private var pickEmoji10
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Button("Test S") {
                            Task {
                                emoji1 = (try? await pickEmoji1(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .controlSize(.large)
                        .buttonStyle(.bordered)
                        Spacer()
                        Text(emoji1)
                    }
                    .padding(.horizontal)
                    .flowSheet($pickEmoji1) {
                        ForEach($pickEmoji1.input, id: \.self) { emoji in
                            Button(emoji) {
                                $pickEmoji1.resume(returning: emoji)
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .padding()
                        }
                        Button("Cancel", action: $pickEmoji1.cancel)
                            .controlSize(.large)
                            .padding()
                    }
                    
                    HStack {
                        Button("Test N") {
                            Task {
                                emoji2 = (try? await pickEmoji2(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji2)
                    }
                    .padding(.horizontal)
                    .flowNavigationDestination($pickEmoji2) {
                        ForEach($pickEmoji2.input, id: \.self) { emoji in
                            Button(emoji) {
                                $pickEmoji2.resume(returning: emoji)
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .padding()
                        }
                        Button("Cancel", action: $pickEmoji2.cancel)
                            .controlSize(.large)
                            .padding()
                    }
                    
                    HStack {
                        Button("Test S->S") {
                            Task {
                                emoji3 = (try? await pickEmoji3(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji3)
                    }
                    .padding(.horizontal)
                    .flowSheet($pickEmoji3) {
                        PickEmojiSheetFlow(flowDismissIsDisabled: false)
                    }
                    
                    HStack {
                        Button("Test S->Sdd") {
                            Task {
                                emoji4 = (try? await pickEmoji4(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji4)
                    }
                    .padding(.horizontal)
                    .flowSheet($pickEmoji4) {
                        PickEmojiSheetFlow(flowDismissIsDisabled: true)
                    }
                    
                    HStack {
                        Button("Test S->N") {
                            Task {
                                emoji5 = (try? await pickEmoji5(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji5)
                    }
                    .padding(.horizontal)
                    .flowSheet($pickEmoji5) {
                        NavigationStack {
                            PickEmojiNavigationDestinationFlow(dismissFlow: false)
                        }
                    }
                    
                    HStack {
                        Button("Test S->Ndd") {
                            Task {
                                emoji6 = (try? await pickEmoji6(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji6)
                    }
                    .padding(.horizontal)
                    .flowSheet($pickEmoji6) {
                        NavigationStack {
                            PickEmojiNavigationDestinationFlow(dismissFlow: true)
                        }
                    }
                    
                    HStack {
                        Button("Test N->S") {
                            Task {
                                emoji7 = (try? await pickEmoji7(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji7)
                    }
                    .padding(.horizontal)
                    .flowNavigationDestination($pickEmoji7) {
                        PickEmojiSheetFlow(flowDismissIsDisabled: false)
                    }
                    
                    HStack {
                        Button("Test N->Sdd") {
                            Task {
                                emoji8 = (try? await pickEmoji8(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji8)
                    }
                    .padding(.horizontal)
                    .flowNavigationDestination($pickEmoji8) {
                        PickEmojiSheetFlow(flowDismissIsDisabled: true)
                    }
                    
                    HStack {
                        Button("Test N->N") {
                            Task {
                                emoji9 = (try? await pickEmoji9(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji9)
                    }
                    .padding(.horizontal)
                    .flowNavigationDestination($pickEmoji9) {
                        PickEmojiNavigationDestinationFlow(dismissFlow: false)
                    }
                    
                    HStack {
                        Button("Test N->Ndd") {
                            Task {
                                emoji10 = (try? await pickEmoji10(["😊", "🐻", "⚽"])) ?? "⁉️"
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                        Text(emoji10)
                    }
                    .padding(.horizontal)
                    .flowNavigationDestination($pickEmoji10) {
                        PickEmojiNavigationDestinationFlow(dismissFlow: true)
                    }
                }
                .padding()
                VStack {
                    Text("Legend")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("S: Sheet")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("N: Navigation Destination")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Xdd: dismiss disabled for X")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.horizontal)
                .padding(.horizontal)
            }
            .navigationTitle("SwiftUI Flow Demo")
        }
    }
}



private struct PickEmojiFlow: View {
    
    @FlowInput<[String], String> private var emojis
    
    @ResumeFlow<[String], String> private var pickEmoji
    
    @CancelFlow<[String], String> private var cancel
    
    var body: some View {
        VStack {
            ForEach(emojis, id: \.self) { emoji in
                Button(emoji) {
                    pickEmoji(emoji)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding()
            }
            Button("Cancel", role: .cancel, action: cancel)
                .controlSize(.large)
                .padding()
            Button("Error", role: .destructive) {
                $pickEmoji.resume(throwing: DemoError())
            }
            .controlSize(.large)
            .padding()
        }
    }
}

private struct PickEmojiSheetFlow: View {
    
    @CancelFlow<[String], String> private var cancel
    
    @ResumeFlow<[String], String> private var returnEmoji
    
    @FlowInput<[String], String> private var emojis
    
    @Flow<[String], String> private var pickEmoji
    
    let flowDismissIsDisabled: Bool
    
    var body: some View {
        VStack {
            Button("Pick") {
                Task {
                    let emoji = (try? await pickEmoji(["😊", "🐻", "⚽"])) ?? "⁉️"
                    returnEmoji(emoji)
                }
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding()
            Button("Cancel", role: .cancel, action: cancel)
                .controlSize(.large)
                .padding()
            Button("Error", role: .destructive) {
                $returnEmoji.resume(throwing: DemoError())
            }
            .controlSize(.large)
            .padding()
        }
        .flowSheet($pickEmoji) {
            PickEmojiFlow()
                .flowDismissDisabled(flowDismissIsDisabled)
        }
    }
}

private struct PickEmojiNavigationDestinationFlow: View {
    
    @CancelFlow<[String], String> private var cancel
    
    @ResumeFlow<[String], String> private var returnEmoji
    
    @FlowInput<[String], String> private var emojis
    
    @Flow<[String], String> private var pickEmoji
    
    let dismissFlow: Bool
    
    var body: some View {
        VStack {
            Button("Pick") {
                Task {
                    let emoji = (try? await pickEmoji(["😊", "🐻", "⚽"])) ?? "⁉️"
                    returnEmoji(emoji)
                }
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding()
            Button("Cancel", role: .cancel, action: cancel)
                .controlSize(.large)
                .padding()
            Button("Error", role: .destructive) {
                $returnEmoji.resume(throwing: DemoError())
            }
            .controlSize(.large)
            .padding()
        }
        .flowNavigationDestination($pickEmoji) {
            PickEmojiFlow()
                .flowDismissDisabled(dismissFlow)
        }
    }
}

struct DemoError: Error {}
