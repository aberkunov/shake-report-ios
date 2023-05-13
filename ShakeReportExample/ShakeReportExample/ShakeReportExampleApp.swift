//
//  ShakeReportExampleApp.swift
//  ShakeReportExample
//
//  Created by Ibrahim Yilmaz on 12.05.23.
//

import SwiftUI
import ShakeReport

@main
struct ShakeReportExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ShakeReportMainView(viewModel: ShakeReportMainViewModelImpl())
        }
    }
}
