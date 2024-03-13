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
    
}
