import Foundation
import UIKit

public struct Screenshot: Identifiable {
    public let id = UUID()
    public let uiImage: UIImage?
    
    public init() {
        var screenshotImage: UIImage?
        
        let window = UIWindow.current
        
        guard let layer = window?.layer else {
            uiImage = nil
            return
        }
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            uiImage = nil
            return
        }
        layer.render(in: context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        uiImage = screenshotImage
    }
}

extension UIWindow {
    static var current: UIWindow? {
        if let sceneWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first {
            return sceneWindow
        }
        
        return nil
    }
}
