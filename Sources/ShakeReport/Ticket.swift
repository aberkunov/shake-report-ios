import Foundation

public struct Ticket {
    public let reporter: User
    public let assignee: User
    public let team: Team
    public let component: Component
    public let sprint: Sprint
    public let priority: TicketPriority
    
    public let title: String
    public let description: String
    public let screenshots: [Data]
}
