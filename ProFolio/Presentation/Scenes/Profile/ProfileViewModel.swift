//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let profileUseCase: ProfileUseCase
    private var cancellables = Set<AnyCancellable>()
    private let userId: String
    
    init(profileUseCase: ProfileUseCase, userId: String) {
        self.profileUseCase = profileUseCase
        self.userId = userId
    }
    
    func loadProfile() {
        isLoading = true
        errorMessage = nil
        
        profileUseCase.getProfile(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
