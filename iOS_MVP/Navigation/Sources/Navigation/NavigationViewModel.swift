import SwiftUI
import Foundation

public final class NavigationViewModel: ObservableObject {
    @Published var currentScreen: Screen?
    var navigationType: NavigationType = .push
    
    var screenStack = NavigationStack() {
        didSet {
            self.currentScreen = screenStack.top()
        }
    }
    
    public init() {}
    
    public func push(screeView: AnyView) {
        self.navigationType = .push
        let screen = Screen(view: screeView)
        screenStack.push(screen)
    }
    
    public func pop() {
        self.navigationType = .pop
        screenStack.pop()
    }
    
    public func popToRoot() {
        self.navigationType = .popToRoot
        screenStack.popToRoot()
    }
}

