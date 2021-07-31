//
//  CardView.swift
//  Steamy
//
//  Created by Mikhail Sumawan on 7/22/21.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var person: Person
    
    @Binding var fullscreenMode: Bool
    
    @EnvironmentObject var userApi: UserApi
    
    @Binding var showNewMatchView: Bool
    
    let screenCutoff = (UIScreen.main.bounds.width / 2) * 0.8
    
    @Namespace var imageNamespace
    
    var body: some View {
        GeometryReader { geo in
            if fullscreenMode {
                FullScreenCardView(person: person, fullscreenMode: $fullscreenMode, showNewMatchView: $showNewMatchView, nameSpace: imageNamespace)
//                    .animation(.easeOut(duration: 0.2))
            } else {
                CardImageScroller(person: person, fullscreenMode: $fullscreenMode)
//                    .animation(.easeOut(duration: 0.2))
                    .frame(width: geo.size.width - 20, height: geo.size.height)
                    .padding(.leading, 10)
                    .matchedGeometryEffect(id: "image\(person.uid)", in: imageNamespace)
                    .offset(x: person.x, y: person.y)
                    .rotationEffect(.degrees(person.degree))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.default) {
                                    person.x = value.translation.width
                                    person.y = value.translation.height
                                    withAnimation {
                                        person.degree = Double((value.translation.width / 25) * -1)
                                    }
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 10, initialVelocity: 0)) {
                                    let width = value.translation.width

                                    if width >= 0 && width <= screenCutoff {
                                        // snap back to middle
                                        person.x = 0
                                        person.y = 0
                                        person.degree = 0

                                    } else if width <= -1 && width >= -screenCutoff {
                                        // snap back to middle
                                        person.x = 0
                                        person.y = 0
                                        person.degree = 0

                                    } else if width > screenCutoff {
                                        // swipe right
                                        person.x = 500
                                        person.degree = 12
                                        userApi.swipe(person: person, direction: .like) { matchedPerson in
                                            userApi.currentMatchedPersonID = matchedPerson.uid
                                            self.showNewMatchView = true
                                        }

                                    } else if width < -screenCutoff {
                                        // swipe left
                                        person.x = -500
                                        person.degree = -12
                                        userApi.swipe(person: person, direction: .nope) { matchedPerson in
                                            //
                                        }
                                    }
                                }
                            })
                    )
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(person: Person.example, fullscreenMode: .constant(false), showNewMatchView: .constant(false))
    }
}
