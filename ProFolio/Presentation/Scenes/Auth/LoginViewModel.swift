
//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // For demo, we just simulate login after a delay
    func login() {
        isLoading = true
        errorMessage = nil
        
        // Simulate network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isLoading = false
            if self?.email == "demo@profolio.com" && self?.password == "password" {
                self?.isLoggedIn = true
            } else {
                self?.errorMessage = "Invalid credentials. Try demo@profolio.com / password"
            }
        }
    }
}
