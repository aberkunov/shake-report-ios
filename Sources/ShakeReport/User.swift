public struct User: Decodable, Identifiable, Hashable {
    public let id: String
    public var name: String
    public let iconUrl: String
}
