//
//  MedicineListView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/13.
//

import SwiftUI

struct MedicineListView: View {
    
    @ObservedObject var viewModel: MedicineViewModel
    let medicine: Medicine
    
    var body: some View {
        listView
    }
    
}

//#Preview {
//    MedicineListView(viewModel: <#MedicineViewModel#>, medicine: Medicine(context: PersistenceController.shared.container.viewContext))
//}

extension MedicineListView {
    
    private var listView: some View {
        ZStack {
            Rectangle()
                .frame(height: 75)
                .foregroundColor(Color(uiColor: .systemBackground))
                .cornerRadius(20)
            HStack {
                VStack {
                    Text(medicine.name ?? "お薬")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(medicine.dosage ?? "適量")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                VStack {
                    Text(viewModel.formatTime(date: medicine.time ?? Date()))
                        .font(.title.bold())
                        .foregroundColor(Color(uiColor: .label))
                    Text("に毎日通知します")
                        .font(.caption)
                        .foregroundColor(Color(uiColor: .label))
                }
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 1)
        )
    }
    
}
