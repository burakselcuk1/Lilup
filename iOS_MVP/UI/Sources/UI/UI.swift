import SwiftUI

public protocol IImageModifier {
    associatedtype Body: View
    func body(image: Image) -> Self.Body
}

extension Image {
    public func modifier<M>(_ modifier: M) -> some View where M: IImageModifier {
        modifier.body(image: self)
    }
}

protocol IText {
    init(with string: String, font: Font, color: Color)
}

extension Text: IText {
    init(with string: String, font: Font, color: Color) {
        var result = AttributedString(string)
        result.font = font
        result.foregroundColor = color
        self.init(result)
    }
}
