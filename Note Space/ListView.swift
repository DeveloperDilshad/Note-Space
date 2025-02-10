//
//  ListView.swift
//  Note Space
//
//  Created by Dilshad P on 04/02/25.
//

import SwiftUI

struct ListView: View {
    
    @State private var notes : [Note] = []
    @State private var showNotesSheet = false
    @State private var searchText : String = ""
    @State private var selectedNote : Note?
    @State private var isNewNote = false
    @State private var selectedCategory : Note.Category?
    
    private let notkey = ""
    private let noteColors : [Color] = [.blue,.green,.yellow,.red,.purple,.orange,.pink,.brown]
    
    var filteredNotes : [Note] {
        var filtered = notes
        if let category = selectedCategory{
            filtered = filtered.filter{
                $0.category == category
            }
        }
        if !searchText.isEmpty{
            filtered = filtered.filter{
                $0.text.localizedCaseInsensitiveContains(searchText)
            }
        }
        return filtered
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 12){
                        CategoryButton(title: "All", icon: "note.text", isSelected: selectedCategory == nil){
                            withAnimation{selectedCategory = nil}
                        }
                        ForEach(Note.Category.allCases,id: \.self) { category in
                            CategoryButton(title: category.rawValue, icon: category.iconName, isSelected: selectedCategory == category){
                                withAnimation{selectedCategory = category}
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical,8)
                
                
                ZStack{
                    Color(.systemBackground)
                    
                    if filteredNotes.isEmpty{
                        VStack(spacing:12){
                            Image(systemName: "note.text")
                                .font(.system(size:60))
                                .foregroundStyle(Color.gray)
                            
                            Text(searchText.isEmpty ? "No notes yet" : "No matches found")
                                .font(.title)
                                .foregroundStyle(Color.gray)
                        }
                    }else {
                        LazyVGrid(columns:[GridItem(.flexible()),GridItem(.flexible())], spacing: 16){
                            ForEach(filteredNotes) { note in
                                NoteCard(note: note, color: noteColors[note.colorIndex]){
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ListView()
}
