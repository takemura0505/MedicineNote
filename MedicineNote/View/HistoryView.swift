//
//  HistoryView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/16.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var historyViewModel: MedicationHistoryViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    historyViewModel.deleteAllMedicationHistory()
                }, label: {
                    Text("全ての履歴を削除")
                        .background(.clear)
                        .foregroundColor(.red)
                        .padding()
                })
            }
            medicineHistoryView
        }
        .navigationBarTitle("履歴", displayMode: .inline)
    }
    
}

//#Preview {
//    HistoryView(historyViewModel: <#MedicationHistoryViewModel#>)
//}

extension HistoryView {
    
    private var medicineHistoryView: some View {
        List(historyViewModel.medicineHistoryData) { medicine in
            HStack {
                Text(medicine.name ?? "")
                Spacer()
                Text(medicine.date?.formatted() ?? "--")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            historyViewModel.fetchMedicineHistory()
        }
    }
    
}
