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
    
    func addMedicine(name: String, dosage: String, timeString: Date) {
        let newMedicine = Medicine(context: context)
        newMedicine.id = UUID().uuidString
        newMedicine.name = name
        newMedicine.dosage = dosage
        newMedicine.time = timeString
        do {
            try context.save()
            fetchMedicines()
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
                print("Medication deleted successfully")
            } else {
                print("No medication found with the given ID")
            }
        } catch {
            print("Error deleting medication: \(error)")
        }
    }
    
    func updateMedicine(id: String, newName: String, newDosage: String, newTimeString: Date) {
        let fetchRequest: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try context.fetch(fetchRequest)
            if let medicineToUpdate = results.first {
                medicineToUpdate.name = newName
                medicineToUpdate.dosage = newDosage
                medicineToUpdate.time = newTimeString
                try context.save()
                fetchMedicines()
            }
        } catch {
            print(error)
        }
    }
    
}
