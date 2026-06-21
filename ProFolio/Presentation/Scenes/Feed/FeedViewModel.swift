//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import Combine
import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var currentPage = 0
    private let feedUseCase: FeedUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(feedUseCase: FeedUseCase) {
        self.feedUseCase = feedUseCase
    }
    
    func loadFeed() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        feedUseCase.execute(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
}
