//
//  CategoryButton.swift
//  Note Space
//
//  Created by Dilshad P on 04/02/25.
//

import SwiftUI

struct CategoryButton: View {
    
    let title : String
    let icon : String
    let isSelected : Bool
    let action : () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            VStack(spacing:6){
                Image(systemName: icon)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
            .frame(width: 70)
            .padding()
            .background(isSelected ? Color.blue.opacity(0.3) : Color.clear)
            .foregroundStyle(isSelected ? .blue : .gray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3),lineWidth: 1)
            )
        }
    }
}

#Preview {
    CategoryButton(title: "Personal", icon: "person.circle", isSelected: true, action: {})
}
