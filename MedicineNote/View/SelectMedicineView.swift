//
//  SelectMedicineView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/16.
//

import SwiftUI

struct SelectMedicineView: View {
    
    @ObservedObject var viewModel: MedicineViewModel
    let medicine: Medicine
    @State private var isTapped: Bool = false
    var onTap: () -> Void
    
    var body: some View {
        listView
            .onTapGesture {
                onTap()
                isTapped.toggle()
            }
    }
    
}

//#Preview {
//    SelectMedicineView(viewModel: <#T##MedicineViewModel#>, medicine: <#T##Medicine#>)
//}

extension SelectMedicineView {
    
    private var listView: some View {
        ZStack {
            Rectangle()
                .frame(height: 75)
                .foregroundColor(isTapped ? Color.lightGray : Color(uiColor: .systemBackground))
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
                Text(viewModel.formatTime(date: medicine.time ?? Date()))
                    .font(.title.bold())
                    .foregroundColor(Color(uiColor: .label))
                isTapped ? Image(systemName: "checkmark") : Image(systemName: "circle")
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 1)
        )
    }
    
}
