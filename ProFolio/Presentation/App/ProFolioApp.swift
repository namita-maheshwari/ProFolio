//
//  ProFoliAPP.swift
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import SwiftUI
import Combine

class AppState: ObservableObject {   // ← must be a class with ObservableObject
    @Published var isLoggedIn = false
}

@main
struct ProFolioApp: App {
    @StateObject private var appState = AppState()  
    private let container = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                MainTabView(container: container)
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}

struct MainTabView: View {
    let container: AppDIContainer
    let userId = "u1" // hardcoded for demo
    
    var body: some View {
        TabView {
            FeedView(viewModel: container.makeFeedViewModel())
                .tabItem {
                    Label("Feed", systemImage: "house")
                }
            
            ConnectionsView(viewModel: container.makeConnectionsViewModel(userId: userId), userId: userId)
                .tabItem {
                    Label("Connections", systemImage: "person.2")
                }
            
            JobsView(viewModel: container.makeJobsViewModel())
                .tabItem {
                    Label("Jobs", systemImage: "briefcase")
                }
            
            MessagesView(viewModel: container.makeMessagesViewModel(userId: userId), userId: userId)
                .tabItem {
                    Label("Messages", systemImage: "message")
                }
            
            ProfileView(viewModel: container.makeProfileViewModel(userId: userId), userId: userId)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
