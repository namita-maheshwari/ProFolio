import Foundation

class AppDIContainer {
    // Data Sources
    let mockAPIService = MockAPIService()
    
    // Mappers
    let userMapper = UserMapper()
    let postMapper = PostMapper()
    let jobMapper = JobMapper()
    let messageMapper = MessageMapper()
    
    // Repositories
    func makeFeedRepository() -> FeedRepository {
        DefaultFeedRepository(remoteDataSource: mockAPIService,
                              postMapper: postMapper,
                              userMapper: userMapper)
    }
    
    func makeProfileRepository() -> ProfileRepository {
        DefaultProfileRepository(remoteDataSource: mockAPIService,
                                 userMapper: userMapper)
    }
    
    func makeConnectionRepository() -> ConnectionRepository {
        DefaultConnectionRepository(remoteDataSource: mockAPIService,
                                    userMapper: userMapper)
    }
    
    func makeJobRepository() -> JobRepository {
        DefaultJobRepository(remoteDataSource: mockAPIService,
                             jobMapper: jobMapper)
    }
    
    func makeMessageRepository() -> MessageRepository {
        DefaultMessageRepository(remoteDataSource: mockAPIService,
                                 messageMapper: messageMapper)
    }
    
    // Use Cases
    func makeFeedUseCase() -> FeedUseCase {
        FeedUseCase(repository: makeFeedRepository())
    }
    
    func makeProfileUseCase() -> ProfileUseCase {
        ProfileUseCase(repository: makeProfileRepository())
    }
    
    func makeConnectionUseCase() -> ConnectionUseCase {
        ConnectionUseCase(repository: makeConnectionRepository())
    }
    
    func makeJobUseCase() -> JobUseCase {
        JobUseCase(repository: makeJobRepository())
    }
    
    func makeMessageUseCase() -> MessageUseCase {
        MessageUseCase(repository: makeMessageRepository())
    }
    
    // ViewModels (with user ID hardcoded for demo)
    func makeFeedViewModel() -> FeedViewModel {
        FeedViewModel(feedUseCase: makeFeedUseCase())
    }
    
    func makeProfileViewModel(userId: String = "u1") -> ProfileViewModel {
        ProfileViewModel(profileUseCase: makeProfileUseCase(), userId: userId)
    }
    
    func makeConnectionsViewModel(userId: String = "u1") -> ConnectionsViewModel {
        ConnectionsViewModel(connectionUseCase: makeConnectionUseCase(), userId: userId)
    }
    
    func makeJobsViewModel() -> JobsViewModel {
        JobsViewModel(jobUseCase: makeJobUseCase())
    }
    
    func makeMessagesViewModel(userId: String = "u1") -> MessagesViewModel {
        MessagesViewModel(messageUseCase: makeMessageUseCase(), userId: userId)
    }
}