import SwiftUI
import UIKit

public struct ShakeReport {
    private static let viewTag = 2635289
    static let floatingView: ShakeReportFloatingView = ShakeReportFloatingView(viewModel: ShakeReportFloatingPanelViewModel())
    
    public static func show() {
        guard let currentWindow = UIWindow.current, currentWindow.viewWithTag(viewTag) == nil else { return }
        
        let floatingViewHosting = UIHostingController(rootView: floatingView)
        floatingViewHosting.view.backgroundColor = .clear
        
        let intrinsicContentSize = floatingViewHosting.view.intrinsicContentSize
        let width = intrinsicContentSize.width
        let height = intrinsicContentSize.height
        let xOffset = currentWindow.bounds.width - width - 4
        let yOffset = currentWindow.bounds.height - height - 150.0
        floatingViewHosting.view.frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
        floatingViewHosting.view.tag = viewTag
        currentWindow.addSubview(floatingViewHosting.view)
        
//
//        let mainViewModel = ShakeReportMainViewModelImpl(reportingService: reportingService)
//        ShakeReportMainView(viewModel: mainViewModel)
    }
    
    public static func close() {
        guard let currentWindow = UIWindow.current, let floatingWindow = currentWindow.viewWithTag(viewTag) else { return }
        
        floatingWindow.removeFromSuperview()
    }
}
