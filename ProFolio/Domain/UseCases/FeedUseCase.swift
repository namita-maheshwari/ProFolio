import Combine
import Foundation

public final class FeedUseCase {
    private let repository: FeedRepository
    
    public init(repository: FeedRepository) {
        self.repository = repository
    }
    
    public func execute(page: Int) -> AnyPublisher<[Post], Error> {
        repository.getFeed(page: page)
    }
}