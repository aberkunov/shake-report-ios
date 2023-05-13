import SwiftUI

protocol MainViewModel: ObservableObject {
    var components: [Component] { get set }
    var priorities: [TicketPriority] { get set }
    var teams: [Team] { get set }
    var sprints: [Sprint] { get set }
    
    var selectedComponent: Component? { get set }
    var selectedPriority: TicketPriority? { get set }
    var selectedTeam: Team? { get set }
    var selectedSprint: Sprint? { get set }
    
    var screenshots: [Screenshot] { get set }
    
    var title: String { get set }
    var description: String { get set }
}

class MainViewModelImpl: MainViewModel {
    
    @Published var components = [Component]()
    @Published var priorities = [TicketPriority]()
    @Published var teams = [Team]()
    @Published var sprints = [Sprint]()
    @Published var users = [User]()
    
    @Published var selectedComponent: Component?
    @Published var selectedPriority: TicketPriority?
    @Published var selectedTeam: Team?
    @Published var selectedSprint: Sprint?
    @Published var selectedUser: User?
    
    @Published var title = ""
    @Published var description = ""
    var screenshots = [
        Screenshot(image: Image(systemName: "person")),
        Screenshot(image: Image(systemName: "person")),
        Screenshot(image: Image(systemName: "person"))
    ]
    
    private let adapter = ReportingServiceImpl()
    
    private func setUp() async {
        do {
            components = try await adapter.getComponents()
            priorities = try await adapter.getPrioritoies()
            teams = try await adapter.getTeams()
            sprints = try await adapter.getSprints()
            users = try await adapter.getUsers()
        } catch {
            print(error)
        }
    }
}

struct Screenshot: Identifiable {
    let id = UUID()
    let image: Image
}
