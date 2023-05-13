import Foundation

public class AttachmentStore {
    static public let shared = AttachmentStore()
    
    private init() { }
    
    public private(set) var screenshots: [Screenshot] = []
    public private(set) var screenRecordings: [String] = []
    
    func makeScreenshot() {
        screenshots.append(Screenshot())
    }
    
    func clearAll() {
        screenshots = []
        screenRecordings = []
    }
}
