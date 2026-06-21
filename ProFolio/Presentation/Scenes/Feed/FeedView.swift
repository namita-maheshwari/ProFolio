//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                PostRow(post: post)
            }
            .navigationTitle("Feed")
            .overlay(Group {
                if viewModel.isLoading {
                    ProgressView()
                }
            })
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.loadFeed()
            }
            .refreshable {
                viewModel.loadFeed()
            }
        }
    }
}

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: post.author.profilePictureURL)) { image in
                    image.resizable()
                } placeholder: {
                    Circle().fill(Color.gray.opacity(0.3))
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(post.author.name)
                        .font(.headline)
                    Text(post.author.headline)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(post.timestamp, style: .relative)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Text(post.content)
                .font(.body)
            
            HStack {
                Label("\(post.likes)", systemImage: "hand.thumbsup")
                Label("\(post.comments.count)", systemImage: "bubble.right")
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
