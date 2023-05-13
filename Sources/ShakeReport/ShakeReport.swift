import SwiftUI

public struct ShakeReport {
    @ViewBuilder
    public static func create(
        service: ReportingService
    ) -> some View {
        let mainViewModel = ShakeReportMainViewModelImpl()
        ShakeReportMainView(viewModel: mainViewModel)
    }
}
