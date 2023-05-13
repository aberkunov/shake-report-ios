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
    
    func create() async
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
    @Published public var selectedReporter: User?
    @Published public var selectedAssignee: User?
    
    @Published public var title = ""
    @Published public var description = ""
    public var screenshots: [Screenshot] = [
//        Screenshot(image: UIImage(systemName: "person")!),
//        Screenshot(image: UIImage(systemName: "person")!),
//        Screenshot(image: UIImage(systemName: "person")!)
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
    
    public func create() async {
        let ticket = Ticket(
            reporter: selectedReporter,
            assignee: selectedAssignee,
            team: selectedTeam,
            component: selectedComponent,
            sprint: selectedSprint,
            priority: selectedPriority,
            title: title,
            description: description,
            screenshots: screenshots.compactMap({ $0.uiImage?.jpegData(compressionQuality: 0.8) })
        )
        
        do {
            try await reportingService.create(ticket)
        } catch {
            print(error)
        }
    }
}
