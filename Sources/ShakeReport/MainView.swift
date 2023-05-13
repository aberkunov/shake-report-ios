import SwiftUI

struct SwiftUIView<ViewModel: MainViewModel>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
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
                
                TextField("TITLE", text: $viewModel.title, axis: .vertical)
                    .padding(8)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)
                
                TextField("BACKGROUND TO STORY", text: $viewModel.description, axis: .vertical)
                    .padding(8)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)
                
                
                Spacer()
            }.padding()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(viewModel: MainViewModelImpl())
    }
}
