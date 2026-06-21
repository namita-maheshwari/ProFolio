
//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//
import SwiftUI

struct ConnectionsView: View {
    @StateObject private var viewModel: ConnectionsViewModel
    let userId: String
    
    init(viewModel: ConnectionsViewModel, userId: String) {
        self.userId = userId
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.connections) { user in
                ConnectionRow(user: user)
            }
            .navigationTitle("Connections")
            .overlay(Group {
                if viewModel.isLoading { ProgressView() }
            })
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.loadConnections()
            }
            .refreshable {
                viewModel.loadConnections()
            }
        }
    }
}

struct ConnectionRow: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.profilePictureURL)) { image in
                image.resizable()
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text(user.headline)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button("Message") {
                // Navigate to chat (not implemented here)
            }
            .buttonStyle(.bordered)
        }
    }
}
