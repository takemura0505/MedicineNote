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
    
    func deleteAllMedicationHistory() {
        // 特定のエンティティタイプ（MedicationHistory）に関連する全てのオブジェクトをフェッチするリクエストを作成
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MedicineHistory.fetchRequest()
        
        // フェッチリクエストを使用して削除リクエストを作成
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            // コンテキストを通じて削除を実行
            try context.execute(deleteRequest)
            // コンテキストの変更を保存
            try context.save()
            fetchMedicineHistory()
            print("Successfully deleted all medication history.")
        } catch {
            // エラーハンドリング
            print("Failed to delete all medication history: \(error)")
        }
    }
    
}
