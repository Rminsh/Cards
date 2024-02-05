//
//  SettingsView.swift
//  Cards
//
//  Created by Armin on 7/23/23.
//

import SwiftUI
import SymbolPicker

struct SettingsView {
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentedSheet: SheetSection?
    
    @AppStorage("leftOptionIcon") var leftOptionIcon: String = "hand.thumbsdown.circle"
    @AppStorage("leftOptionTitle") var leftOptionTitle: String = "Forgot"
    
    @AppStorage("rightOptionIcon") var rightOptionIcon: String = "hand.thumbsup.circle"
    @AppStorage("rightOptionTitle") var rightOptionTitle: String = "Knew"
    
    enum SheetSection: String, Identifiable {
        case left, right
        var id: String { rawValue }
    }
}

extension SettingsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color.background
                    .ignoresSafeArea(.all)
                #endif
                
                #if os(visionOS)
                ScrollView {
                    VStack {
                        content
                            .padding()
                    }
                }
                #else
                List {
                    content
                }
                #endif
            }
            #if os(iOS)
            .scrollContentBackground(.hidden)
            #endif
            .navigationTitle("Cards swipes")
            .toolbar {
                ToolbarItem {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        #if os(iOS)
                        Label("Close", systemImage: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                        #elseif os(macOS)
                        Text("Close")
                        #elseif os(visionOS)
                        Label("Close", systemImage: "xmark")
                        #endif
                    }
                }
            }
            .sheet(item: $presentedSheet) { sheet in
                switch sheet {
                case .left:
                    SymbolPicker(symbol: $leftOptionIcon)
                case .right:
                    SymbolPicker(symbol: $rightOptionIcon)
                }
            }
        }
    }
    
    var content: some View {
        Group {
            DirectionSection(
                title: "Right Section",
                icon: rightOptionIcon,
                description: "Right section title",
                text: $rightOptionTitle
            ) {
                presentedSheet = .right
            }
            
            DirectionSection(
                title: "Left Section",
                icon: leftOptionIcon,
                description: "Left section title",
                text: $leftOptionTitle
            ) {
                presentedSheet = .left
            }
        }
    }
}

#Preview {
    SettingsView()
}
