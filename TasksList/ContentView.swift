//
//  ContentView.swift
//  TasksList
//
//  Created by Маргарита Бабухадия on 22.04.2024.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    var id = UUID()
    var task: String
    var description: String
    var isDone: Bool
}

class ListItem: ObservableObject {
    @Published var items = [Item]()
}

struct ContentView: View {
    @ObservedObject var tasks = ListItem()
    @State private var showingAdd = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("Задач на сегодня: \(tasks.items.filter { $0.isDone == false }.count)")
                    .padding(.leading)
                List {
                    ForEach(Array(tasks.items.enumerated()), id: \.offset) { i, e in
                        HStack{
                            VStack(alignment: .leading){
                                Text("Задача №\(i+1)")
                                    
                                Text(e.task)
                                    .font(.title2)
                                    .bold()
                                Text(e.description)
                                    .font(.footnote)
                            }
                            Spacer()
                            Button {
                                tasks.items[i].isDone.toggle()
                            } label: {
                                Image (systemName:
                                        e.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.green)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                .navigationTitle("Список дел на день")
                .navigationBarItems(trailing:
                                        Button(action:{
                    self.showingAdd = true
                }) {
                    Image (systemName: "plus")
                        .foregroundColor(.green)
                        .font(.title2)
                    
                }) .sheet(isPresented: $showingAdd) {
                    AddItem(tasks: self.tasks)
                }
            }
        }
    }
    
    func removeItems(as offsets: IndexSet) {
        tasks.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
