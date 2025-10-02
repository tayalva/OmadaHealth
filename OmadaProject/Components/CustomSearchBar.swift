//
//  CustomSearchBar.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import SwiftUI

/// A reusable SwiftUI search bar component with a clear button and editable text binding.
///
/// `CustomSearchBar` provides a text field styled as a search bar, complete with a magnifying glass icon,
/// a clear button that appears when the text is not empty, and support for editing state.
/// It is designed to be easily integrated into SwiftUI views, allowing for two-way binding of the search text.
struct CustomSearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $text)
                    .padding(8)
                    .padding(.horizontal, 30)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)

                            if !text.isEmpty {
                                Button(action: {
                                    text = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .onTapGesture {
                        isEditing = true
                    }
            }
            .padding(.horizontal)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    CustomSearchBar(text: .constant(""))
}
