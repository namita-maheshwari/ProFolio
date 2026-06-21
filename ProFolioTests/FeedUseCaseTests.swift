import XCTest
import Combine
@testable import ProFolio

final class FeedUseCaseTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    var mockRepo: MockFeedRepository!
    var useCase: FeedUseCase!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockRepo = MockFeedRepository()
        useCase = FeedUseCase(repository: mockRepo)
    }
    
    override func tearDown() {
        cancellables = nil
        mockRepo = nil
        useCase = nil
        super.tearDown()
    }
    
    func testExecute_PropagatesError() {
        let error = NSError(domain: "test", code: -1)
        mockRepo.result = .failure(error)
        let exp = expectation(description: "Error propagated")
        
        useCase.execute(page: 0)
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    XCTAssertEqual((err as NSError).domain, error.domain)
                    exp.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
    }
}

// Mock
class MockFeedRepository: FeedRepository {
    var result: Result<[Post], Error> = .success([])
    func getFeed(page: Int) -> AnyPublisher<[Post], Error> {
        result.publisher
            .delay(for: .milliseconds(10), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
