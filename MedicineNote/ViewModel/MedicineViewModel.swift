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
    
    func addMedicine(name: String, dosage: String, timeString: String) {
        let newMedicine = Medicine(context: context)
        newMedicine.id = UUID().uuidString
        newMedicine.name = name
        newMedicine.dosage = dosage
        
        // StringからDateへの変換
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let time = dateFormatter.date(from: timeString) {
            newMedicine.time = time
        } else {
            print("Date conversion failed")
            return
        }
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
}
