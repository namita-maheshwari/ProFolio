# 📱 ProFolio – Professional Networking App

**ProFolio** is a modern, feature‑rich iOS app inspired by LinkedIn, built entirely in **SwiftUI** with a **Clean Architecture** and reactive state management using **Combine**. It comes with a fully functional mock backend, so you can run and explore the app immediately without setting up a server.

---

## ✨ Features

- **Feed** – View posts from your network with likes and comments.
- **Profile** – See user details, headline, email, and connection count.
- **Connections** – Browse your network and send/accept connection requests.
- **Jobs** – Browse job listings with remote/onsite badges and apply with one tap.
- **Messages** – Read and send direct messages (mock chat).
- **Authentication** – Login screen with validation (demo credentials provided).
- **Splash Screen** – Branded launch screen (iOS 15+ via `Info.plist` or custom animated SwiftUI view).
- **Offline‑Ready** – All data is served from local JSON files; no internet required.

---

## 🏗️ Architecture

ProFolio follows **Clean Architecture** principles, dividing the code into three distinct layers:

- **Domain** – Pure Swift business logic: entities, use cases, and repository protocols. No UIKit or SwiftUI here.
- **Data** – Repository implementations, remote data sources (mock API), and mappers to convert DTOs to domain models.
- **Presentation** – SwiftUI views, `ObservableObject` view models, and navigation. All state is driven by Combine publishers.

### Data Flow

- Repositories return `AnyPublisher<Model, Error>`.
- Use cases combine and transform publishers.
- ViewModels subscribe to use cases and update `@Published` properties, which SwiftUI observes.

---

## 🛠️ Technologies

- **Swift** – 100% native.
- **SwiftUI** – Declarative UI.
- **Combine** – Reactive programming.
- **Clean Architecture** – Separation of concerns, testability.
- **XCTest** – Unit tests included (Use Cases, Repositories, ViewModels).
- **JSON** – Mock data source (no external dependencies).

---

## 📁 Project Structure
ProFolio/
├── Domain/
│ ├── Entities/ (User, Post, Job, Message, Comment)
│ ├── UseCases/ (Feed, Profile, Connection, Job, Message)
│ └── Repositories/ (Protocols)
├── Data/
│ ├── Repositories/ (Default implementations)
│ ├── DataSources/ (Remote protocols + MockAPIService)
│ └── Mappers/ (DTO ↔ Domain)
├── Presentation/
│ ├── Scenes/ (Auth, Feed, Profile, Connections, Jobs, Messages)
│ ├── Common/ (Components, Extensions)
│ └── App/ (ProFolioApp, AppDIContainer, AppState)
└── Resources/
└── MockData/ (users.json, posts.json, jobs.json, messages.json)


---

## 🚀 Getting Started

### Prerequisites

- Xcode 14.0 or later (Swift 5.7+)
- iOS 15.0+ deployment target

### Installation

1. Clone the repository: (bash)
git clone https://github.com/yourusername/ProFolio.git
cd ProFolio
open ProFolio.xcodeproj

## Login Credentials**
Use the following demo account to log in:
Email: demo@profolio.com
Password: password

## Screenshots

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 38 24" src="https://github.com/user-attachments/assets/370b4d00-991c-4652-b56e-9e03d4f2289d" />
<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 37 57" src="https://github.com/user-attachments/assets/f511d44e-e40f-41bb-8c94-9349326fef15" />
<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 37 54" src="https://github.com/user-attachments/assets/350ec64a-1278-4b91-8e39-58d045b20555" />
<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 37 51" src="https://github.com/user-attachments/assets/ee899ded-4c6a-41b2-81ed-0184154edad2" />
<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 37 49" src="https://github.com/user-attachments/assets/ba33072d-e582-4fe2-a357-f53bfa4bce53" />
<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 37 46" src="https://github.com/user-attachments/assets/a3b22167-2227-4297-8ae1-17fc473c9056" />
<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 37 40" src="https://github.com/user-attachments/assets/6513438d-4339-407e-af60-ea5b1dd416c8" />
<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 17e - 2026-06-21 at 14 36 58" src="https://github.com/user-attachments/assets/435b55bc-7f4f-4804-9e8c-9a0ffa6169bf" />

