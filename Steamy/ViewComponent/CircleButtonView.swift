//
//  CircleButtonView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/22/21.
//

import SwiftUI

enum ButtonType: String {
    case no = "xmark"
    case heart = "heart.fill"
}

struct CircleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Circle()
                            .foregroundColor(Color.white)
            )
            .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}

struct ColorButton: ViewModifier {
    var type : ButtonType
    
    func body(content: Content) -> some View {
        switch type {
        case .no:
            return AnyView(content.foregroundColor(.red))
        case .heart:
            return AnyView(content.foregroundColor(.green))
        
        }
    }
}

extension View {
    func colorButton(type: ButtonType) -> some View {
        self.modifier(ColorButton(type: type))
    }
}
    
struct CircleButtonView: View {
    
    var type: ButtonType
    var action: () -> Void
    
    var body: some View {
        Button(action: { action() }) {
            Image(systemName: type.rawValue)
                .resizable()
                .font(.system(size: 12, weight: .bold))
                .aspectRatio(contentMode: .fit)
                .padding(12)
        }
        .buttonStyle(CircleButton())
        .colorButton(type: type)
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                CircleButtonView(type: .no, action: {})
                    .frame(height: 50)
                
                CircleButtonView(type: .heart, action: {})
                    .frame(height: 50)
                
            }
        }
        
    }
}
