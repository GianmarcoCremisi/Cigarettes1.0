//
//  cigarettesApp.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 15/11/23.
//

import SwiftUI
import SwiftData

@main
struct cigarettesApp: App {
    var body: some Scene {
        WindowGroup {
            
            TabView{
                ContentView().tabItem {
                    Image(systemName: "person.fill").foregroundStyle(.black)
                        
                        Text("Counter")
                    }
                
                HistoryView().tabItem {
                    Image(systemName: "book.circle").foregroundStyle(.teal)
                        
                        Text("History")
                    }
            }
            .preferredColorScheme(.dark)
            .tint(.white)
            
        }
        .modelContainer(for: CigaretteData.self)
        
    }
}
