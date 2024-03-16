//
//  MedicineHistoryViewModel.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/16.
//

import CoreData
import Foundation

class MedicationHistoryViewModel: ObservableObject {
    
    private var context: NSManagedObjectContext
    @Published var medicineHistoryData: [MedicineHistory] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchMedicineHistory()
    }
    
    func fetchMedicineHistory() {
        let request: NSFetchRequest<MedicineHistory> = MedicineHistory.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            medicineHistoryData = try context.fetch(request)
        } catch {
            medicineHistoryData = []
            print(error)
        }
    }
    
    func addMedicineHistory(name: String, dosage: String, date: Date) {
        // 新しいMedicationHistoryインスタンスを作成
        let newHistory = MedicineHistory(context: context)
        newHistory.id = UUID().uuidString
        newHistory.name = name
        newHistory.dosage = dosage
        newHistory.date = date
        
        // コンテキストに変更を保存
        do {
            try context.save()
            fetchMedicineHistory()
            print("Medication history successfully added.")
        } catch {
            print("Failed to save medication history: \(error)")
        }
    }
    
}
