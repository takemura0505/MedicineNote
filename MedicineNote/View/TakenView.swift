//
//  TakenView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/16.
//

import SwiftUI

struct TakenView: View {
    
    @ObservedObject var viewModel: MedicineViewModel
    @ObservedObject var historyViewModel: MedicationHistoryViewModel
    @State var selectedMedicine: [Medicine] = []
    @Binding var showingTakenSheet: Bool
    
    var body: some View {
        VStack {
            selectView
            takenButtonView
            Spacer(minLength: 40)
        }
    }
    
}

//#Preview {
//    TakenView(viewModel: MedicineViewModel(context: PersistenceController.shared.container.viewContext), showingTakenSheet: <#Binding<Bool>#>)
//}

extension TakenView {
    
    var selectView: some View {
        ScrollView {
            Spacer(minLength: 40)
            ForEach(viewModel.medicineData, id: \.self) { medicine in
                SelectMedicineView(viewModel: viewModel, medicine: medicine, onTap: {
                    if let index = selectedMedicine.firstIndex(where: { $0 == medicine }) {
                        // 既に選択されている場合は削除
                        selectedMedicine.remove(at: index)
                    } else {
                        // 未選択の場合は追加
                        selectedMedicine.append(medicine)
                    }
                    print("Selected Medicines: \(selectedMedicine.count)")
                })
                .padding(.horizontal)
            }
        }
    }
    
    var takenButtonView: some View {
        ZStack {
            Capsule()
                .frame(width: 250, height: 50)
                .foregroundColor(Color(uiColor: .label))
            Text("飲んだ")
                .foregroundColor(Color(uiColor: .systemBackground))
        }
        .onTapGesture {
            selectedMedicine.forEach { medicine in
                historyViewModel.addMedicineHistory(name: medicine.name ?? "", dosage: medicine.dosage ?? "", date: Date())
                showingTakenSheet = false
            }
        }
    }
    
}
