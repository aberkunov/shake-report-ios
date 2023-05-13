import SwiftUI

public struct ShakeReport {
    @ViewBuilder
    public static func create(
        reportingService: ReportingService
    ) -> some View {
        let mainViewModel = ShakeReportMainViewModelImpl(reportingService: reportingService)
        ShakeReportMainView(viewModel: mainViewModel)
    }
}
