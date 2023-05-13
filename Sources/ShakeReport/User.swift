public struct User: Decodable, Identifiable, Hashable {
    public let id: String
    public let key: String
    public let name: String
    public let avatarUrls: [String : String]
    public let displayName: String
}
