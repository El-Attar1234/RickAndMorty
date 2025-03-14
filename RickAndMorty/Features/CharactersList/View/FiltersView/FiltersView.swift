//
//  FiltersView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//

import SwiftUI

struct FiltersView: View {
    @Binding var selectedStatus: CharacterStatus?

    private let filters: [(title: String, status: CharacterStatus?)] = [
        ("All", nil)
    ] + CharacterStatus.allCases.map { ($0.rawValue, $0) }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(filters, id: \.title) { filter in
                    FilterButton(
                        title: filter.title,
                        isSelected: selectedStatus == filter.status,
                        action: {
                            selectedStatus = filter.status
                        }
                    )
                }
            }
        }
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .medium))
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .foregroundColor(isSelected ? .white : .primary)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.blue : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .onTapGesture {
                action()
            }
    }
}
