//
//  MedicineNoteApp.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/11.
//

import SwiftUI

@main
struct MedicineNoteApp: App {
    
    init() {
        requestNotificationPermission()
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("success")
            } else {
                print(error)
            }
        }
    }
    
}
