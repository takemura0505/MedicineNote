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
    
    var body: some View {
        VStack {
            medicineScheduleView
            buttonView
        }
        .sheet(isPresented: $showingSheet) {
            SettingView(showingSheet: $showingSheet)
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    
    var buttonView: some View {
        ZStack {
            HStack {
                drunkButtonView
                historyButtonView
            }
            addButtonView
                .onTapGesture {
                    showingSheet = true
                }
        }
    }
    
    var addButtonView: some View {
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
    
    var drunkButtonView: some View {
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
    
    var historyButtonView: some View {
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
    
    var medicineScheduleView: some View {
        ScrollView {
            ForEach(viewModel.medicineData, id: \.self) { medicine in
                MedicineListView(medicine: medicine)
                    .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.fetchMedicines()
            
        }
    }
    
}
