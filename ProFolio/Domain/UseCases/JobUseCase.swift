import Combine
import Foundation

public final class JobUseCase {
    private let repository: JobRepository
    
    public init(repository: JobRepository) {
        self.repository = repository
    }
    
    public func getJobs() -> AnyPublisher<[Job], Error> {
        repository.getJobs()
    }
    
    public func apply(to jobId: String) -> AnyPublisher<Void, Error> {
        repository.apply(to: jobId)
    }
}