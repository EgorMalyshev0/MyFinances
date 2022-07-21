//
//  AddCategoryScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.07.2022.
//

import SwiftUI

struct AddCategoryScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: AddCategoryViewModel
    @State var showingDeleteAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                TextField("Название", text: $viewModel.categoryName)
                NavigationLink {
                    SelectIconScreen(iconName: $viewModel.iconName)
                } label: {
                    HStack {
                        Text("Иконка")
                        Spacer()
                        Image(systemName: viewModel.iconName)
                    }
                }
            }
            Section {
                ForEach([TransactionType.expense, TransactionType.income], id: \.self) { type in
                    SelectCategoryTypeRow(type: type, selectedType: $viewModel.transactionType)
                }
            }
        }
        .toolbar {
            HStack {
                Button {
                    showingDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .tint(.red)
                }
                .opacity(viewModel.isEditing ? 1 : 0)
                Button("Сохранить") {
                    viewModel.saveCategory()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(viewModel.saveButtonDisabled)
            }
            
        }
        .alert("Удалить категорию?", isPresented: $showingDeleteAlert, actions: {
            Button("Удалить", role: .destructive) {
                viewModel.deleteCategory()
                presentationMode.wrappedValue.dismiss()
            }
            Button("Отмена", role: .cancel) {}
        })
        .accentColor(.green)
    }
}
