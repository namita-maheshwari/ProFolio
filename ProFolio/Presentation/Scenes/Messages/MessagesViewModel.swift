//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import Combine
import SwiftUI

class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let messageUseCase: MessageUseCase
    private var cancellables = Set<AnyCancellable>()
    private let userId: String
    
    init(messageUseCase: MessageUseCase, userId: String) {
        self.messageUseCase = messageUseCase
        self.userId = userId
    }
    
    func loadMessages() {
        isLoading = true
        errorMessage = nil
        
        messageUseCase.getMessages(for: userId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] msgs in
                self?.messages = msgs
            }
            .store(in: &cancellables)
    }
    
    func sendMessage(text: String, to receiverId: String) {
        let newMessage = Message(id: UUID().uuidString,
                                 senderId: userId,
                                 receiverId: receiverId,
                                 text: text,
                                 timestamp: Date(),
                                 isRead: false)
        messageUseCase.sendMessage(newMessage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] _ in
                self?.messages.append(newMessage)
            }
            .store(in: &cancellables)
    }
}
