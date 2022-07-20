//
//  AddTransactionScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI
import RealmSwift
import Intents

struct AddTransactionScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: AddTransactionScreenViewModel
    
    @ObservedResults(Category.self) var categories

    var body: some View {
        VStack {
            Picker("Выберите тип операции", selection: $viewModel.selectedTransactionType) {
                ForEach(TransactionType.allCases, id: \.self) {
                    Text($0.textDescription)
                        .tag($0)
                }
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: viewModel.selectedTransactionType) { _ in
                viewModel.selectedCategory = nil
                viewModel.selectedTargetAccount = nil
            }
            List {
                BalanceRow(balance: $viewModel.amount, title: "Сумма")
                
                if viewModel.selectedTransactionType != .transfer {
                    NavigationLink {
                        SelectCategoryScreen(transactionType: viewModel.selectedTransactionType, selectedCategory: $viewModel.selectedCategory)
                    } label: {
                        Text(viewModel.selectedCategory?.name ?? "Выберите категорию")
                            .foregroundColor(viewModel.selectedCategory == nil ? .secondary : .primary)
                    }
                    NavigationLink {
                        SelectAccountScreen(selectedAccount: $viewModel.selectedAccount)
                    } label: {
                        Text(viewModel.selectedAccount?.name ?? "Выберите счет")
                            .foregroundColor(viewModel.selectedAccount == nil ? .secondary : .primary)
                    }
                } else {
                    NavigationLink {
                        SelectAccountScreen(selectedAccount: $viewModel.selectedAccount)
                    } label: {
                        Text(viewModel.selectedAccount?.name ?? "Откуда перевести")
                            .foregroundColor(viewModel.selectedAccount == nil ? .secondary : .primary)
                    }
                    NavigationLink {
                        SelectAccountScreen(selectedAccount: $viewModel.selectedTargetAccount)
                    } label: {
                        Text(viewModel.selectedTargetAccount?.name ?? "Куда перевести")
                            .foregroundColor(viewModel.selectedTargetAccount == nil ? .secondary : .primary)
                    }
                }
                
                DatePicker("Дата", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ru_RU"))
                    .labelsHidden()
            }
        }
        .toolbar {
            HStack {
                Button("Удалить") {
                    viewModel.deleteTransaction()
                }
                .opacity(viewModel.isEditing ? 1 : 0)
                Button("Сохранить") {
                    viewModel.saveTransaction()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(viewModel.savingEnable())
            }
            
        }
        .accentColor(.green)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
