import Foundation
import SwiftUI

public enum Transition {
    case none
    case custom(AnyTransition)
}

enum NavigationType {
    case pop
    case push
    case popToRoot
}
