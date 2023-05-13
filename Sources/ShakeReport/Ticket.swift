import Foundation

public struct Ticket {
    public let reporter: User?
    public let assignee: User?
    public let team: Team?
    public let component: Component?
    public let sprint: Sprint?
    public let priority: TicketPriority?
    
    public let title: String
    public let description: String
    public let screenshots: [Data?]
    public let ticketInfo: TicketInfo?
    
    public init(reporter: User? = nil, assignee: User? = nil, team: Team? = nil, component: Component? = nil, sprint: Sprint? = nil, priority: TicketPriority? = nil, title: String, description: String, screenshots: [Data?], ticketInfo: TicketInfo? = nil) {
        self.reporter = reporter
        self.assignee = assignee
        self.team = team
        self.component = component
        self.sprint = sprint
        self.priority = priority
        self.title = title
        self.description = description
        self.screenshots = screenshots
        self.ticketInfo = ticketInfo
    }
}
