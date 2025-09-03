import SwiftUI
import Combine

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    private var hasFetched = false
    
    func fetchUsers() async {
        // ✅ Prevent duplicate fetching
        guard !hasFetched else { return }
        hasFetched = true
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            users = try JSONDecoder().decode([User].self, from: data)
            print(users)
        } catch {
            print("❌ Fetch error:", error.localizedDescription)
        }
    }
}
