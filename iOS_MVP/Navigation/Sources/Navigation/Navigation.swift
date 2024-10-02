import Foundation
import SwiftUI

public struct Navigation<Content: View>: View {
    @ObservedObject var viewModel: NavigationViewModel = .init()
    private let content: Content
    private let transition: (push: AnyTransition, pop: AnyTransition)
    private let animation: Animation = .easeOut(duration: 0.3)
    
    public init(transition: Transition, @ViewBuilder content: @escaping() -> Content) {
        self.content = content()
        switch transition {
        case .none:
            self.transition = (.identity, .identity)
        case .custom(let anyTransition):
            self.transition = (anyTransition, anyTransition)
        }
    }
    
    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                self.content.environmentObject(self.viewModel)
                    .animation(animation, value: 1)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            }
            else {
                viewModel.currentScreen?.view.environmentObject(self.viewModel)
                    .animation(animation, value: 1)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            }
        }
    }
}

