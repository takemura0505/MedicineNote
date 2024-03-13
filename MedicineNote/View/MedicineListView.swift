//
//  MedicineListView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/13.
//

import SwiftUI

struct MedicineListView: View {
    
    @StateObject var viewModel = MedicineViewModel(context: PersistenceController.shared.container.viewContext)
    let medicine: Medicine
    
    var body: some View {
        listView
    }
    
}

#Preview {
    MedicineListView(medicine: Medicine(context: PersistenceController.shared.container.viewContext))
}

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
                    Text(medicine.dosage ?? "適量")
                        .font(.title3)
                }
                Spacer()
                Text(viewModel.formatTime(date: medicine.time ?? Date()))
                    .font(.title.bold())
                    .foregroundColor(Color(uiColor: .label))
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 1)
        )
    }
    
}
