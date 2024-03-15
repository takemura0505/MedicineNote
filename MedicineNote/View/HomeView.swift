//
//  HomeView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/11.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = MedicineViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var showingSheet = false
    @State private var selectedMedicine: Medicine? = nil
    
    
    var body: some View {
        VStack {
            topBarView
            medicineScheduleView
            buttonView
        }
        .sheet(isPresented: $showingSheet) {
            SettingView(showingSheet: $showingSheet, viewModel: viewModel, medicine: selectedMedicine)
        }
        .presentationDetents([.medium])
    }
    
}

#Preview {
    HomeView()
}

extension HomeView {
    
    private var topBarView: some View {
        HStack {
            Spacer()
            Text("今日のお薬")
                .font(.title3.bold())
            Spacer()
        }
        .padding()
    }
    
    private var buttonView: some View {
        ZStack {
            HStack {
                drunkButtonView
                historyButtonView
            }
            addButtonView
                .onTapGesture {
                    selectedMedicine = nil
                    showingSheet = true
                }
        }
    }
    
    private var addButtonView: some View {
        ZStack {
            Circle()
                .frame(height: 100)
                .padding(.bottom)
                .foregroundColor(.lightOrange)
            VStack {
                Image(systemName: "plus")
                    .font(.title)
                    .padding(5)
                Text("追加")
                    .font(.caption)
            }
        }
    }
    
    private var drunkButtonView: some View {
        ZStack {
            Rectangle()
                .frame(height: 80)
                .foregroundColor(.lightGreen)
            VStack {
                Image(systemName: "mug")
                    .font(.title)
                    .padding(5)
                Text("もう飲んだ")
                    .font(.caption)
            }
        }
    }
    
    private var historyButtonView: some View {
        ZStack {
            Rectangle()
                .frame(height: 80)
                .foregroundColor(.lightPink)
            VStack {
                Image(systemName: "clock")
                    .font(.title)
                    .padding(5)
                Text("履歴")
                    .font(.caption)
            }
        }
    }
    
    private var medicineScheduleView: some View {
        ScrollView {
            Spacer(minLength: 5)
            ForEach(viewModel.medicineData, id: \.self) { medicine in
                MedicineListView(viewModel: viewModel, medicine: medicine)
                    .padding(.horizontal)
                    .onTapGesture {
                        selectedMedicine = medicine
                        showingSheet = true
                    }
            }
        }
        .onAppear {
            viewModel.fetchMedicines()
        }
    }
    
}
