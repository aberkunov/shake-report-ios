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
            ShakeReportMainView(viewModel: ShakeReportMainViewModelImpl(reportingService: MockedReportingService()))
        }
    }
}

struct MockedReportingService: ReportingService {
    func getComponents() async -> [Component] {
        return []
    }
    
    func getTeams() async -> [Team] {
        return []
    }
    
    func getPrioritoies() async -> [TicketPriority] {
        return []
    }
    
    func getSprints() async -> [Sprint] {
        return []
    }
    
    func getUsers() async -> [User] {
        return []
    }
    
    func create(_ ticket: Ticket) async throws {
        
    }
}
