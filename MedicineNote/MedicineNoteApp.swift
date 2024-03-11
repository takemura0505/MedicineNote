//
//  MedicineNoteApp.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/11.
//

import SwiftUI

@main
struct MedicineNoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
