//
//  AddedItemView.swift
//  To do list 2
//
//  Created by Erin Chon on 1/24/23.
//

import SwiftUI

struct AddedItemView: View {
    @ObservedObject var toDoList: ToDoList
    @State private var priority = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let priorities = ["High", "Medium", "Low"]
    var body: some View {
        NavigationView{
            Form {
                Picker("Priority", selection: $priority) {
                    ForEach(Self.priorities, id: \.self) { priority in
                        Text(priority)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New To-Do Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if priority.count > 0 && description.count > 0 {
                    let item = ToDoItem(id: UUID(), priority: priority,
                                        description: description, dueDate : dueDate)
                    toDoList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddedItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddedItemView(toDoList: ToDoList())
    }
}
