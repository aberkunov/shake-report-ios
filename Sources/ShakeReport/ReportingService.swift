protocol ReportingService {
    func getComponents() async -> [Component]
    func getTeams() async -> [Team]
    func getPrioritoies() async -> [TicketPriority]
    func getSprints() async -> [Sprint]
    func getUsers() async -> [User]
}

struct ReportingServiceImpl: ReportingService {
    func getComponents() async -> [Component] {
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
}
