//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState // to navigate after login
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            LogoView()
            Text("ProFolio")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: viewModel.login) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)
            
            Spacer()
        }
        .padding()
        .onReceive(viewModel.$isLoggedIn) { loggedIn in
            if loggedIn {
                appState.isLoggedIn = true
            }
        }
    }
}

//// AppState for global navigation
//class AppState: ObservableObject {
//    @Published var isLoggedIn = false
//}
