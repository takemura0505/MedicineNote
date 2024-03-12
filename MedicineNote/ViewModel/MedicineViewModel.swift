//
//  MedicineViewModel.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/12.
//

import CoreData

class MedicineViewModel: ObservableObject {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addMedicine(name: String, dosage: String, time: Date) {
        let newMedicine = Medicine(context: context)
        newMedicine.id = UUID().uuidString
        newMedicine.name = name
        newMedicine.dosage = dosage
        newMedicine.time = time
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func fetchMedicines() -> [Medicine] {
        let request: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
}
