//
//  ContentView.swift
//  TasksList
//
//  Created by Маргарита Бабухадия on 22.04.2024.
//

import SwiftUI

class Item: Identifiable, Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var task: String
    var description: String
    var isDone: Bool
    
    init(task: String, description: String) {
        self.id = UUID()
        self.task = task
        self.description = description
        self.isDone = false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class Data: ObservableObject {
    static let shared: Data = Data()
    
    @Published var items = [Item]()
    private init() { }
}



struct ContentView: View {
    @ObservedObject var tasks = Data.shared
    @State private var showingAdd = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("Задач на сегодня: \(tasks.items.filter { $0.isDone == false }.count)")
                    .padding(.leading)
                List {
                    ForEach(tasks.items, id: \.self) { i in
                        HStack{
                            VStack(alignment: .leading){
                                Text("Задача №\(1)")
                                    
                                Text(i.task)
                                    .font(.title2)
                                    .bold()
                                Text(i.description)
                                    .font(.footnote)
                            }
                            Spacer()
                            Button {
                                i.isDone.toggle()
                            } label: {
                                Image (systemName:
                                        i.isDone ? "checkmark.circle.fill" : "circle")
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
                    AddItem()
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
