import Combine
import Foundation

public protocol FeedRepository {
    func getFeed(page: Int) -> AnyPublisher<[Post], Error>
}