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
        isMinimized ? 70 : 0
    }
    
    private var buttonImageName: String {
        isMinimized ? "chevron.compact.left" : "chevron.compact.right"
    }
    
    private var chevronForegroundColor: Color {
        isMinimized ? .accentColor : .secondary.opacity(0.5)
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            Button {
                print("button tap")
                isMinimized = isMinimized ? false : true
            } label: {
                Image(systemName: buttonImageName)
                    .font(.system(size: 40))
                    .foregroundColor(chevronForegroundColor)
            }
            .frame(width: 25, height: 80)
            .background(.ultraThinMaterial)
            .cornerRadius(14, corners: [.topLeft, .bottomLeft])
            
            VStack(spacing: 16) {
                Button {
                    viewModel.takeScreenshot()
                } label: {
                    Image(systemName: "camera")
                }
                
                Divider()
                
                Button {
                    viewModel.recordVideo()
                } label: {
                    Image(systemName: "video")
                }
                
                Divider()
                
                Button {
                    viewModel.sendReport()
                } label: {
                    Image(systemName: "paperplane")
                }
                
                Divider()
                
                Button {
                    viewModel.showLogs()
                } label: {
                    Image(systemName: "terminal")
                }
                
                Divider()
                
                Button {
                    isMinimized = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        ShakeReport.close()
                    }
                } label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .frame(width: 70)
            .background(.ultraThinMaterial)
            .cornerRadius(14)
            .font(.system(size: 20))
        }
        .offset(x: offsetLeading)
        .animation(.default, value: offsetLeading)
    }
}

struct ShakeReportFloatingView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeReportMainView(viewModel: ShakeReportMainViewModelImpl(reportingService: MockedReportingService()))
    }
}
