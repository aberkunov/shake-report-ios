struct TicketPriority: Decodable, Identifiable, Hashable {
    let id: String
    var name: String
    let iconUrl: String
}