//
//  CustomSearchBar.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import SwiftUI

/// A customizable search bar view for SwiftUI.
///
/// `CustomSearchBar` provides a text field with a magnifying glass icon,
/// and a clear button that appears when text is entered. It handles basic
/// search bar interactions, such as starting editing on tap and clearing text.
///
/// The search bar is designed to be used with a `@Binding` string so that
/// the parent view can read and update the search text.
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
