import SwiftUI
import Combine

struct ShakeReportFloatingPanelViewModel {
    private let reportingService: ReportingService
    private let onShowLogs: () -> Void
    
    init(reportingService: ReportingService, onShowLogs: @escaping () -> Void) {
        self.reportingService = reportingService
        self.onShowLogs = onShowLogs
    }
    
    func takeScreenshot() {
        
    }
    
    func recordVideo() {
        
    }
    
    func sendReport() {
        
    }
    
    func showLogs() {
        onShowLogs()
    }
}

struct ShakeReportFloatingView: View {
    private let viewModel: ShakeReportFloatingPanelViewModel
    
    init(viewModel: ShakeReportFloatingPanelViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var isMinimized: Bool = false
    private var offsetLeading: CGFloat {
        isMinimized ? 0 : 150
    }
    
    private var buttonImageName: String {
        isMinimized ? "chevron.compact.right" : "chevron.compact.left"
    }
    
    var body: some View {
        HStack {
            Button {
                print("button tap")
                isMinimized = isMinimized ? false : true
            } label: {
                Image(systemName: buttonImageName)
                    .font(.system(size: 40))
                    .foregroundColor(.accentColor)
                    .frame(width: 25, height: 150)
                    .contentShape(Rectangle())
            }
            
            VStack(spacing: 10) {
                Button("Take a screenshot") {
                    viewModel.takeScreenshot()
                }
                
                Button("Record a video") {
                    viewModel.recordVideo()
                }
                
                Button("Send JIRA report") {
                    viewModel.sendReport()
                }
                
                Button("Show Logs") {
                    viewModel.showLogs()
                }
            }.frame(width: 150, height: 150)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(14)
        .offset(x: offsetLeading)
        .animation(.default, value: offsetLeading)
    }
}
