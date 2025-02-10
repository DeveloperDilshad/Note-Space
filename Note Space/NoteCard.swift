//
//  NoteCard.swift
//  Note Space
//
//  Created by Dilshad P on 04/02/25.
//

import SwiftUI

struct NoteCard: View {
    
    let note:Note
    let color:Color
    let onDelete:()->Void
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12) {
            Text(note.text)
                .font(.body)
                .lineLimit(6)
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)
            
            HStack{
                Text(note.date.formatted(date:.abbreviated,time: .shortened))
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                
                Spacer()
                
                Button(action:onDelete){
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                        .contentShape(Rectangle())
                }
            }
            
        }
        .padding()
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(color.opacity(0.2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color.opacity(0.3),lineWidth: 1)
        )
    }
}

