//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    let userId: String
    
    init(viewModel: ProfileViewModel, userId: String) {
        self.userId = userId
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Group {
                if let user = viewModel.user {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            AsyncImage(url: URL(string: user.profilePictureURL)) { image in
                                image.resizable()
                            } placeholder: {
                                Circle().fill(Color.gray.opacity(0.3))
                            }
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.title)
                                Text(user.headline)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        
                        Text("Email: \(user.email)")
                            .font(.body)
                        
                        if let connections = user.connections {
                            Text("Connections: \(connections.count)")
                                .font(.body)
                        }
                        
                        Spacer()
                    }
                    .padding()
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Profile")
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.loadProfile()
            }
        }
    }
}
