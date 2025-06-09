import SwiftUI

struct TextWithBorderSaracen: View {
    let text: String
    let font: Font
    let textColor: Color
    let borderColor: Color
    let borderWidth: CGFloat

    var body: some View {
        ZStack {
            Text(text)
                .font(font)
                .foregroundColor(textColor)
                .glowBorder(color: borderColor, lineWidth: 5)
            
            
        }
    }
}
   
struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}
