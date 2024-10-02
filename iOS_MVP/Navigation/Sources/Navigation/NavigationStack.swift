import Foundation

struct NavigationStack {
    private var screens = [Screen]()
    
    mutating func push(_ screen: Screen) {
        self.screens.append(screen)
    }
    
    mutating func pop() {
        _ = self.screens.popLast()
    }
    
    mutating func popToRoot() {
        self.screens.removeAll()
    }
    
    func top() -> Screen? {
        return self.screens.last
    }
}
