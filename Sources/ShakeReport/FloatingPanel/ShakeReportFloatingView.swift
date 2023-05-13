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
    
    var body: some View {
        HStack(spacing: .zero) {
            Button {
                print("button tap")
                isMinimized = isMinimized ? false : true
            } label: {
                Image(systemName: buttonImageName)
                    .font(.system(size: 40))
                    .foregroundColor(.secondary.opacity(0.5))
            }
            .frame(width: 25, height: 80)
            .background(.ultraThinMaterial)
            .cornerRadius(14, corners: [.topLeft, .bottomLeft])
            
            VStack(spacing: 16) {
                buttonWithBadge(
                    imageName: "camera",
                    badgeText: "1"
                ) {
                    viewModel.takeScreenshot()
                }
                
                Divider()

                buttonWithBadge(
                    imageName: "video",
                    badgeText: "6"
                ) {
                    viewModel.recordVideo()
                }
                
                Divider()
                
                buttonWithBadge(imageName: "paperplane") {
                    viewModel.sendReport()
                }
                
                Divider()
                
                buttonWithBadge(imageName: "terminal") {
                    viewModel.showLogs()
                }
                
                Divider()

                buttonWithBadge(imageName: "multiply") {
                    isMinimized = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        ShakeReport.close()
                    }
                }.foregroundColor(.red)
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
    
    private func buttonWithBadge(
        imageName: String,
        badgeText: String? = nil,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
            viewModel.takeScreenshot()
        } label: {
            ZStack {
                Image(systemName: imageName)
                
                if let badgeText {
                    Text(badgeText)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .font(.system(size: 12))
                        .background(.red)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .offset(x: 12, y: -10)
                }
            }
        }
    }
}

struct ShakeReportFloatingView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeReportMainView(viewModel: ShakeReportMainViewModelImpl(reportingService: MockedReportingService()))
    }
}
