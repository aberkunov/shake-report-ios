public protocol ReportingService {
    func getComponents(projectId: Int) async -> [Component]
    func getTeams() async -> [Team]
    func getPrioritoies() async -> [TicketPriority]
    func getSprints() async -> [Sprint]
    func getUsers() async -> [User]
    func create(_ ticket: Ticket) async throws -> Ticket?
}

#if DEBUG

struct MockedReportingService: ReportingService {
    func getComponents(projectId: Int) async -> [Component] {
        return []
    }
    
    func getTeams() async -> [Team] {
        return []
    }
    
    func getPrioritoies() async -> [TicketPriority] {
        return [TicketPriority(id: "", name: "", iconUrl: "")]
    }
    
    func getSprints() async -> [Sprint] {
        return []
    }
    
    func getUsers() async -> [User] {
        return []
    }
    
    func create(_ ticket: Ticket) async throws -> Ticket? {
        return nil
    }
}

#endif
