//
//  MedicineViewModel.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/12.
//

import CoreData
import SwiftUI

class MedicineViewModel: ObservableObject {
    
    private var context: NSManagedObjectContext
    @Published var medicineData: [Medicine] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchMedicines()
    }
    
    func addMedicine(name: String, dosage: String, time: Date) {
        let newMedicine = Medicine(context: context)
        let id = UUID().uuidString
        newMedicine.id = id
        newMedicine.name = name
        newMedicine.dosage = dosage
        newMedicine.time = time
        do {
            try context.save()
            fetchMedicines()
            scheduleDailyNotification(id: id, at: time, title: "お薬を飲む時間です", body: "\(name)を\(dosage)飲みましょう")
        } catch {
            print(error)
        }
    }
    
    func fetchMedicines() {
        let request: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        do {
            medicineData = try context.fetch(request)
        } catch {
            medicineData = []
            print(error)
        }
    }
    
    func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func deleteMedicine(id: String) {
        let fetchRequest: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let medicineToDelete = results.first {
                context.delete(medicineToDelete)
                try context.save()
                fetchMedicines()
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
                print("Medication deleted successfully")
            } else {
                print("No medication found with the given ID")
            }
        } catch {
            print("Error deleting medication: \(error)")
        }
    }
    
    func updateMedicine(id: String, newName: String, newDosage: String, newTime: Date) {
        let fetchRequest: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try context.fetch(fetchRequest)
            if let medicineToUpdate = results.first {
                medicineToUpdate.name = newName
                medicineToUpdate.dosage = newDosage
                medicineToUpdate.time = newTime
                try context.save()
                fetchMedicines()
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
                scheduleDailyNotification(id: id, at: newTime, title: "お薬を飲む時間です", body: "\(newName)を\(newDosage)飲みましょう")
            }
        } catch {
            print(error)
        }
    }
    
    func scheduleDailyNotification(id: String, at time: Date, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        let triggerDate = DateComponents(hour: hour, minute: minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling daily notification: \(error)")
            }
        }
    }
    
}
