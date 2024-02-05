//
//  DirectionSection.swift
//  Cards
//
//  Created by Armin on 2/6/24.
//

import SwiftUI

struct DirectionSection {
    var title: String
    var icon: String
    var description: String
    @Binding var text: String
    var action: () -> Void
}

extension DirectionSection: View {
    var body: some View {
        Section {
            HStack {
                Button(action: action) {
                    Image(systemName: icon)
                        .font(.title)
                }
                #if os(iOS)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(radius: 0.5)
                #elseif os(visionOS)
                .clipShape(Circle())
                #endif
                
                TextField(description, text: $text)
                    #if os(visionOS)
                    .textFieldStyle(.roundedBorder)
                    #endif
            }
        } header: {
            Text(title)
                #if os(visionOS)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                #endif
        }
        #if os(iOS)
        .listRowBackground(Color.backgroundSecond)
        #endif
    }
}
