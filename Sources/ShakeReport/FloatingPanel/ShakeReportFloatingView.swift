import SwiftUI
import Combine

struct ShakeReportFloatingPanelViewModel {
    func takeScreenshot() {
        
    }
    
    func recordVideo() {
        
    }
    
    func sendReport() {
        
    }
    
    func showLogs() {
    
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
        HStack(spacing: .zero) {
            Button {
                print("button tap")
                isMinimized = isMinimized ? false : true
            } label: {
                Image(systemName: buttonImageName)
                    .font(.system(size: 40))
                    .foregroundColor(.accentColor)
            }
            .frame(width: 25, height: 80)
            .background(.ultraThinMaterial)
            .cornerRadius(14, corners: [.topLeft, .bottomLeft])
            
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
                
                Button("Close") {
                    
                }
            }
            .frame(width: 150, height: 150)
            .background(.ultraThinMaterial)
            .cornerRadius(14)
        }
        .offset(x: offsetLeading)
        .animation(.default, value: offsetLeading)
    }
}
