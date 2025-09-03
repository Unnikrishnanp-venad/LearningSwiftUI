import SwiftUI

struct User: Identifiable, Codable {
    let id: Int
    var name: String   // editable
    var company: Company?
}

struct Company: Codable {
    let name: String
}

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns ) {
                    ForEach($viewModel.users) { $user in
                        NavigationLink(destination: DetailView(user: $user)) {
                            VStack(spacing: 8) {
                                Text(user.name)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.blue.opacity(0.8))
 
                                if let company = user.company {
                                    Text(company.name)
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(Color.red.opacity(0.8))
                                }
                            }
                            .frame(width:UIScreen.main.bounds.width * 0.4, height:  UIScreen.main.bounds.width * 0.4)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Users")
            .task {   // ✅ async on appear
                await viewModel.fetchUsers()
            }
        }
    }
}
