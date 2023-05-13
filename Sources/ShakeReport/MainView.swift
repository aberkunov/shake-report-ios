import SwiftUI

public struct ShakeReportMainView<ViewModel: ShakeReportMainViewModel>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    @State private var zoomed: Bool = false
    @Namespace var namespace
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        var selectedImage = UIImage()
        if zoomed {
            Image(uiImage: selectedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 800)
                .border(.gray.opacity(0.2))
                .matchedGeometryEffect(id: "title", in: namespace)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .onTapGesture {
                    withAnimation {
                        zoomed.toggle()
                    }
                }
        } else {
            ScrollView {
                VStack(alignment: .leading) {
                    Picker(selection: $viewModel.selectedComponent, label: Text("")) {
                        ForEach($viewModel.components) {
                            Text($0.name.wrappedValue).tag($0.id)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        Text("Priority:")
                        
                        Picker(selection: $viewModel.selectedPriority, label: Text("")) {
                            ForEach($viewModel.priorities) {
                                Text($0.name.wrappedValue).tag($0.id)
                            }
                        }
                        .pickerStyle(.menu)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                    HStack {
                        Text("Team:")
                        
                        Picker(selection: $viewModel.selectedTeam, label: Text("")) {
                            ForEach($viewModel.teams) {
                                Text($0.name.wrappedValue).tag($0.id)
                            }
                        }
                        .pickerStyle(.menu)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                    
                    HStack {
                        Text("Sprint:")
                        
                        Picker(selection: $viewModel.selectedSprint, label: Text("")) {
                            ForEach($viewModel.sprints) {
                                Text($0.name.wrappedValue).tag($0.id)
                            }
                        }
                        .pickerStyle(.menu)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                    
                    if #available(iOS 16.0, *) {
                        TextField("TITLE", text: $viewModel.title, axis: .vertical)
                            .padding(8)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(12)
                        
                        TextField("BACKGROUND TO STORY", text: $viewModel.description, axis: .vertical)
                            .frame(minHeight: 100)
                            .padding(8)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(12)
                            .lineLimit(5)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(viewModel.screenshots) { screenshot in
                                Image(uiImage: screenshot.uiImage ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .border(.gray.opacity(0.2))
                                    .matchedGeometryEffect(id: "title", in: namespace)
                                    .onTapGesture {
                                        withAnimation {
                                            zoomed.toggle()
                                            selectedImage = screenshot.uiImage ?? UIImage()
                                        }
                                    }
                                    .frame(height: 100)
                            }
                        }
                    }
                }.padding()
                
                Button("Create Ticket") {
                    Task {
                        await viewModel.create()
                    }
                }
                .frame(width: 300)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .onAppear {
                ShakeReport.create(reportingService: MockedReportingService()) {
                    // nothing
                }
            }
        }
    }
}

struct ShakeReportMainView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeReportMainView(viewModel: ShakeReportMainViewModelImpl(reportingService: MockedReportingService()))
    }
}
