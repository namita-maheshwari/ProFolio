//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import Combine
import SwiftUI

class ConnectionsViewModel: ObservableObject {
    @Published var connections: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let connectionUseCase: ConnectionUseCase
    private var cancellables = Set<AnyCancellable>()
    private let userId: String
    
    init(connectionUseCase: ConnectionUseCase, userId: String) {
        self.connectionUseCase = connectionUseCase
        self.userId = userId
    }
    
    func loadConnections() {
        isLoading = true
        errorMessage = nil
        
        connectionUseCase.getConnections(for: userId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.connections = users
            }
            .store(in: &cancellables)
    }
}
