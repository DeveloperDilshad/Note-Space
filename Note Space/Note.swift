//
//  Note.swift
//  Note Space
//
//  Created by Dilshad P on 04/02/25.
//

import Foundation

struct Note: Identifiable,Codable {
    
    let id : UUID
    let text: String
    let date: Date
    let category: Category
    let colorIndex : Int
    
    init(id: UUID = UUID(), text: String, date: Date, category: Category, colorIndex: Int) {
        self.id = id
        self.text = text
        self.date = date
        self.category = category
        self.colorIndex = colorIndex
    }
    
    enum Category : String, Codable,CaseIterable {
        case personal = "Personal"
        case work = "Work"
        case study = "Study"
        case ideas = "Ideas"
        case tasks = "Tasks"
        
        var iconName : String {
            switch self {
            case .personal:
                return "person.circle"
            case .work:
                return "briefcase"
            case .study:
                return "book"
            case .ideas:
                return "lightbulb"
            case.tasks:
                return "checkmark"
            }
        }
    }
    
}
