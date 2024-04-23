//
//  AddItem.swift
//  TasksList
//
//  Created by Маргарита Бабухадия on 22.04.2024.
//

import SwiftUI

struct AddItem: View {
    @ObservedObject var tasks = Data.shared
    @State private var task = ""
    @State private var description = ""
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: (some View) {
        NavigationView {
            Form {
                TextField("Задача", text: $task)
                TextField("Описание задачи", text: $description)
                
            }   .navigationBarTitle("Новая задача")
                .navigationBarItems(trailing:
                    Button("Добавить задачу"){
                            let i = Item(task: self.task, description: self.description)
                            self.tasks.items.append(i)
                            self.presentationMode.wrappedValue.dismiss()
                    }.foregroundColor(.green)
                )
        }
    }
}

#Preview {
    AddItem()
}
