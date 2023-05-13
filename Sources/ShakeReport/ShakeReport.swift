import SwiftUI
import UIKit

public struct ShakeReport {
    private static let viewTag = 2635289
    static let floatingView: ShakeReportFloatingView = ShakeReportFloatingView(viewModel: ShakeReportFloatingPanelViewModel())
    
    public static func create() {
        guard let currentWindow = UIWindow.current, currentWindow.viewWithTag(viewTag) == nil else { return }
        
        let floatingViewHosting = UIHostingController(rootView: floatingView)
        
        let width = 175.0
        let height = 150.0
        let xOffset = currentWindow.bounds.width - width
        let yOffset = currentWindow.bounds.height - height - 100.0
        floatingViewHosting.view.frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
        floatingViewHosting.view.tag = viewTag
        currentWindow.addSubview(floatingViewHosting.view)
        
//
//        let mainViewModel = ShakeReportMainViewModelImpl(reportingService: reportingService)
//        ShakeReportMainView(viewModel: mainViewModel)
    }
}
