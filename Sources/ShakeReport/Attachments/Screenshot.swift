import Foundation
import UIKit

public struct Screenshot: Identifiable {
    public let id = UUID()
    public let uiImage: UIImage?
    
    public init() {
        var screenshotImage: UIImage?
        
        let window: UIWindow?
        if let sceneWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first {
            window = sceneWindow
        } else if let keyWindow = UIApplication.shared.keyWindow {
            window = keyWindow
        } else {
            window = nil
        }
        
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
