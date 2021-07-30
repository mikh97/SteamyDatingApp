//
//  MessageListView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI

struct MessageListView: View {
    
    @ObservedObject var vm: MessageListVM = MessageListVM()
    
    @State private var searchText: String = ""
    @State private var isEditing: Bool = false
    @State private var messagePreviews = [MessagePreview]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
                        Text("Messages").multilineTextAlignment(.leading).foregroundColor(Color.red).font(.system(size: 35, weight: .bold))
                        Spacer()
                    }
                    
                    HStack {
                        TextField("Search Matches", text: $searchText)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(Color.gray.opacity(0.9))
                                        .font(.system(size: 20, weight: .bold))
                                        .padding(.leading, 4)
                                    Spacer()
                                }
                            )
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                self.isEditing = true
                            }
                            .animation(.easeIn(duration: 0.25))
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.searchText = ""
                                self.endEditing(true)
                            }, label: {
                                Text("Cancel")
                            })
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.easeIn(duration: 0.25))
                        }
                    }
                    
                    Spacer().frame(height: 14)
                    
                    ZStack {
                        VStack {
                            ForEach(vm.messagePreviews.filter({ searchText.isEmpty ? true : displayPreview($0) }), id: \.self) { preview in
                                NavigationLink(
                                    destination: ChatView(user: preview.user),
                                    label: {
                                        VStack{
                                            MessageRowView(preview: preview)
                                        }
                                        
                                    })
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                        
                        if isEditing && searchText.isEmpty {
                            Color(UIColor.systemGray6).opacity(0.5)
                        }
                        
                    }
                    
                    Spacer()
                }
            }
            .modifier(HideNavigationView())
            .padding(.top, 1)
            .onAppear {
                vm.visible = true
                vm.loadPreviews()
            }
            .onDisappear {
                vm.visible = false
            }
        }
        
    }
    
    func displayPreview(_ preview: MessagePreview) -> Bool {
        // person name
        if preview.user.firstName.contains(searchText) || preview.user.lastName.contains(searchText) {
            return true
        }
        // last message sent
        if preview.text.contains(searchText) {
            return true
        }
        
        return false
    }
    
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MessageListView()
        }
    }
}
