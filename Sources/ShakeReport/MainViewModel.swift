import SwiftUI

public protocol ShakeReportMainViewModel: ObservableObject {
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

public class ShakeReportMainViewModelImpl: ShakeReportMainViewModel {
    
    @Published public var components = [Component]()
    @Published public var priorities = [TicketPriority]()
    @Published public var teams = [Team]()
    @Published public var sprints = [Sprint]()
    @Published public var users = [User]()
    
    @Published public var selectedComponent: Component?
    @Published public var selectedPriority: TicketPriority?
    @Published public var selectedTeam: Team?
    @Published public var selectedSprint: Sprint?
    @Published public var selectedUser: User?
    
    @Published public var title = ""
    @Published public var description = ""
    public var screenshots = [
        Screenshot(image: Image(systemName: "person")),
        Screenshot(image: Image(systemName: "person")),
        Screenshot(image: Image(systemName: "person"))
    ]
    
    private let reportingService: ReportingService
    
    public init(reportingService: ReportingService) {
        self.reportingService = reportingService
    }
    
    private func setUp() async {
        do {
            components = try await reportingService.getComponents()
            priorities = try await reportingService.getPrioritoies()
            teams = try await reportingService.getTeams()
            sprints = try await reportingService.getSprints()
            users = try await reportingService.getUsers()
        } catch {
            print(error)
        }
    }
}

public struct Screenshot: Identifiable {
    public let id = UUID()
    public let image: Image
}
