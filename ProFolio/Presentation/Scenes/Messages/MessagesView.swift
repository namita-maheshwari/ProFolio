//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import SwiftUI

struct MessagesView: View {
    @StateObject private var viewModel: MessagesViewModel
    let userId: String
    
    init(viewModel: MessagesViewModel, userId: String) {
        self.userId = userId
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.messages) { message in
                MessageRow(message: message, currentUserId: userId)
            }
            .navigationTitle("Messages")
            .overlay(Group {
                if viewModel.isLoading { ProgressView() }
            })
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.loadMessages()
            }
            .refreshable {
                viewModel.loadMessages()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New") {
                        // Show chat composer (omitted)
                    }
                }
            }
        }
    }
}

struct MessageRow: View {
    let message: Message
    let currentUserId: String
    
    var body: some View {
        HStack {
            if message.senderId == currentUserId {
                Spacer()
                Text(message.text)
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.text)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
            }
        }
        .padding(.vertical, 2)
    }
}
