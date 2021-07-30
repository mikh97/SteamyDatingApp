//
//  ChatView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/28/21.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var vm: ChatViewVM
    
    @State private var typingMessage: String = ""
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    private var user: User
    
    init(user: User) {
        self.user = user
        self.vm = ChatViewVM(user: user)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                
                Spacer().frame(height: 75)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        
                        LazyVStack {
                            ForEach(vm.messages.indices, id: \.self) { index in
                                let msg = vm.messages[index]
                                MessageView(message: msg)
                                    .id(index)
                            }
                        }
                        .onAppear(perform: {
                            scrollProxy = proxy
                        })
                        
                    }
                }
                .onTapGesture {
                    self.endEditing(true)
                }
                
                ZStack(alignment: .trailing) {
                    
                    Color(.systemGray6)
                    
                    TextField("Type a message", text: $typingMessage)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(height: 45)
                        .padding(.horizontal)
                    
                    Button(action: { sendMessage() }, label: {
                        Text("Send")
                    })
                    .padding(.horizontal)
                    .foregroundColor(typingMessage.isEmpty ? Color.gray : Color.blue)
                    
                }
                .frame(height: 40)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            ChatViewHeader(name: user.firstName, imageURL: URL(string: user.profileImageUrl))
            
        }
        .modifier(HideNavigationView())
        .onChange(of: vm.messages, perform: { _ in
            scrollToBottom()
        })
        .onChange(of: vm.keyboardIsShowing, perform: { value in
            if value {
                scrollToBottom()
            }
        })
    }
    
    func sendMessage() {
        vm.sendMessage(dict: ["text": typingMessage as Any]) {
            // error block
        }
        typingMessage = ""
    }
    
    func scrollToBottom() {
        withAnimation {
            scrollProxy?.scrollTo(vm.messages.count - 1, anchor: .bottom)
        }
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User.example)
    }
}
