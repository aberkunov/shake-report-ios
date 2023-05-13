//
//  ContentView.swift
//  ShakeReportExample
//
//  Created by Ibrahim Yilmaz on 12.05.23.
//
import ShakeReport
import SwiftUI
import QuickLook

struct ContentView: View {
    
    @State private var screenshot: UIImage? = nil
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            if let screenshot {
                Image(uiImage: screenshot)
                    .resizable()
                    .frame(width: 200, height: 300)
                    .border(Color.red, width: 1.0)
            }
            
            Spacer()
            
            Button(action: {
                screenshot = Screenshot().uiImage
            }, label: {
                Text("make screenshot")
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
