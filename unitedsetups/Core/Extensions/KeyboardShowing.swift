//
//  KeyboardShowing.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/12/24.
//

import SwiftUI
import Combine

extension View {
    func addKeyboardVisitibilityToEnvironment() -> some View {
        modifier(KeyboardVisibility())
    }
}

private struct KeyboardShowingEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    public var keyboardShowing: Bool {
        get { self[KeyboardShowingEnvironmentKey.self] }
        set { self[KeyboardShowingEnvironmentKey.self] = newValue }
    }
}

private struct KeyboardVisibility: ViewModifier {
    #if os(macOS)
    fileprivate func body (content: Content) -> some View {
        content.environment(\.keyboardShowing, false)
    }
    #else
    @State var isKeyboardShowing: Bool = false
    
    private var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true},
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in false}
            )
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    fileprivate func body (content: Content) -> some View {
        content
            .environment(\.keyboardShowing, isKeyboardShowing)
            .onReceive(keyboardPublisher) { isKeyboardShowing in
                self.isKeyboardShowing = isKeyboardShowing
            }
    }
    #endif
}
