//
//  NoteEditView.swift
//  Note Space
//
//  Created by Dilshad P on 10/02/25.
//

import SwiftUI

struct NoteEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var notes: [Note]
    let noteKey: String
    let existingNote: Note?
    @State private var isNewNote: Bool   // ✅ Changed from 'let' to '@State'
    let availableColors: [Color]
    
    @State private var noteText: String
    @State private var selectedCatagory: Note.Category
    @State private var selectedColorIndex: Int
    
    init(notes: Binding<[Note]>, noteKey: String, existingNote: Note?, isNewNote: Bool, availableColors: [Color]) {
        self._notes = notes
        self.noteKey = noteKey
        self.existingNote = existingNote
        self._isNewNote = State(initialValue: isNewNote)  // ✅ Initialize as state
        self.availableColors = availableColors
        self._noteText = State(initialValue: existingNote?.text ?? "")
        self._selectedCatagory = State(initialValue: existingNote?.category ?? .personal)
        self._selectedColorIndex = State(initialValue: existingNote?.colorIndex ?? 0)
    }
    
    
    @FocusState private var isFocused:Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing:16){
                Picker("Category", selection: $selectedCatagory) {
                    ForEach(Note.Category.allCases, id: \.self) { catagory in
                        Label(catagory.rawValue, systemImage: catagory.iconName)
                            .tag(catagory)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                
                
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing:12){
                        ForEach(Array(availableColors.enumerated()),id: \.offset) { index, color  in
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white,lineWidth: selectedColorIndex == index ? 2 : 0)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 2,x:0,y:1)
                                .onTapGesture {
                                    selectedColorIndex = index
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                TextEditor(text: $noteText)
                    .focused($isFocused)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
            }
            .navigationTitle(isNewNote ? "New Notes" : "Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        saveNotes()
                    }
                    .bold()
                    .disabled(noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear {
                isFocused = true
            }
        }
    }
    
    private func saveNotes() {
        let trimmedText = noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        print("Saving note with text: '\(trimmedText)'")
        print("existingNote: \(existingNote != nil)")  // ✅ Debug existing note check
        
        if existingNote == nil {  // ✅ Check if it's a new note based on existingNote
            let note = Note(
                text: trimmedText,
                date: Date(),
                category: selectedCatagory,
                colorIndex: selectedColorIndex
            )
            notes.insert(note, at: 0)
        } else if let index = notes.firstIndex(where: { $0.id == existingNote?.id }) {
            notes[index] = Note(
                id: existingNote!.id,
                text: trimmedText,
                date: Date(),
                category: selectedCatagory,
                colorIndex: selectedColorIndex
            )
        }
        
        if let encodedData = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedData, forKey: noteKey)
            print("Notes saved successfully. Total notes: \(notes.count)")
        }
        dismiss()
    }
}


