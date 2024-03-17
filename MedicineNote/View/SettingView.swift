//
//  SettingView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/12.
//

import SwiftUI
import CoreData

struct SettingView: View {
    
    @State private var selectedTime = Date()
    @Binding var showingSettingSheet: Bool
    @ObservedObject var viewModel: MedicineViewModel
    @State private var nameTextField: String = ""
    @State private var dosageTextField: String = ""
    @State private var keyboardHeight: CGFloat = 0
    let medicine: Medicine?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                nameView
                dosage
                timeView
                addButtonView
                if let medicine = medicine {
                    Button("削除") {
                        viewModel.deleteMedicine(id: medicine.id!)
                        showingSettingSheet = false
                    }
                    .foregroundColor(.red)
                }
                Spacer()
            }
            .onAppear {
                setData()
            }
        }
    }
    
}

//#Preview {
//    SettingView()
//}

extension SettingView {
    
    private var nameView: some View {
        VStack {
            Text("お薬の名前")
            TextField("例 : 痛み止め", text: $nameTextField)
                .padding()
                .frame(width: 200, height: 45)
                .background(.lightGray)
                .clipShape(Capsule())
                .foregroundColor(.black)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 5)
        )
    }
    
    private var dosage: some View {
        VStack {
            Text("お薬の量")
            TextField("例 : 2粒", text: $dosageTextField)
                .padding()
                .frame(width: 200, height: 45)
                .background(.lightGray)
                .clipShape(Capsule())
                .foregroundColor(.black)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 5)
        )
    }
    
    private var timeView: some View {
        VStack {
            Text("お薬を飲む時間")
            DatePicker(
                "時間を選択",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 5)
        )
    }
    
    private var addButtonView: some View {
        ZStack {
            Capsule()
                .frame(width: 250, height: 50)
                .foregroundColor(Color(uiColor: .label))
            Text("追加")
                .foregroundColor(Color(uiColor: .systemBackground))
        }
        .onTapGesture {
            updateData()
        }
    }
    
    private func updateData() {
        if let medicine = medicine {
            viewModel.updateMedicine(id: medicine.id ?? "", newName: nameTextField, newDosage: dosageTextField, newTime: selectedTime)
            showingSettingSheet = false
        } else {
            viewModel.addMedicine(name: nameTextField, dosage: dosageTextField, time: selectedTime)
            showingSettingSheet = false
        }
    }
    
    private func setData() {
        if let medicine = medicine {
            nameTextField = medicine.name ?? ""
            dosageTextField = medicine.dosage ?? ""
            selectedTime = medicine.time ?? Date()
        }
    }
    
}
