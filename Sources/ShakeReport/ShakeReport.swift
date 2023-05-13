import SwiftUI
import UIKit

public struct ShakeReport {
    public static func create(
        reportingService: ReportingService,
        onShowLogs: @escaping () -> Void
    ) {
        guard let currentWindow = UIWindow.current else {
            assertionFailure("UIWindow.current is nil")
            return
        }
        
        let viewModel = ShakeReportFloatingPanelViewModel(reportingService: reportingService, onShowLogs: onShowLogs)
        let floatingView = ShakeReportFloatingView(viewModel: viewModel)
        let floatingViewHosting = UIHostingController(rootView: floatingView)
        
        let width = 150.0
        let height = 150.0
        let xOffset = currentWindow.bounds.width - width - 20.0 // with margin
        let yOffset = currentWindow.bounds.height - height - 100.0  // with margin and safe area
        floatingViewHosting.view.frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
        currentWindow.addSubview(floatingViewHosting.view)
        
//
//        let mainViewModel = ShakeReportMainViewModelImpl(reportingService: reportingService)
//        ShakeReportMainView(viewModel: mainViewModel)
    }
}
