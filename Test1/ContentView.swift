//
//  ContentView.swift
//  Test1
//
//  Created by Дмитрий Цепилов on 17.08.2024.
//

import SwiftUI

// Модель данных для item
struct Item: Identifiable {
    let id = UUID()
    let name: String
    var required: Bool
    var tappedOnSelectAll: Bool
    var isSelected: Bool = false
}

// Основное представление
struct ContentView: View {
    @State private var items: [Item] = [
        Item(name: "Красный", required: true, tappedOnSelectAll: false),
        Item(name: "Синий", required: true, tappedOnSelectAll: true),
        Item(name: "Зеленый", required: true, tappedOnSelectAll: false),
        Item(name: "Желтый", required: true, tappedOnSelectAll: true)
    ]
    
    @State private var selectAll: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Чекбокс "Выбрать всё"
            Button(action: toggleSelectAll) {
                HStack {
                    Image(systemName: selectAll ? "checkmark.square" : "square")
                    Text("Выбрать всё")
                }
                .font(.system(size: 16))
                .padding()
            }
            
            // Список с item
            List {
                ForEach($items) { $item in
                    HStack {
                        Button(action: {
                            item.isSelected.toggle()
                            updateSelectAllState()
                        }) {
                            HStack {
                                Image(systemName: item.isSelected ? "checkmark.square" : "square")
                                Text(item.name)
                            }
                            .font(.system(size: 16))
                            .padding()
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
      
            // Кнопка "Отправить"
            Button("Отправить") {
                print("Отправка выполнена")
            }
            .disabled(!canSubmit())
            .padding()
            .background(canSubmit() ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }

    // Обновление состояния чекбокса "Выбрать всё"
    private func toggleSelectAll() {
        selectAll.toggle()
        for index in items.indices where items[index].tappedOnSelectAll {
            items[index].isSelected = selectAll
        }
    }

    // Проверка отправки кнопки
    private func canSubmit() -> Bool {
        // Проверка выбора всех item
        return items.filter { $0.required }.allSatisfy { $0.isSelected }
    }

    // Состояния чекбокса "Выбрать всё"
    private func updateSelectAllState() {
        selectAll = items.filter { $0.tappedOnSelectAll }.allSatisfy { $0.isSelected }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
