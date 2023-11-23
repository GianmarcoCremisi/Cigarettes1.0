//
//  CigarettesDetail.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 18/11/23.
//

//import SwiftUI
//import SwiftData

import SwiftUI
import SwiftData

struct CigarettesDetail: View {
    
    var GiornoDate: Date
    
    @Query(sort: \CigaretteData.date) private var history: [CigaretteData]
    
    var body: some View {
        List {
            ForEach(history.filter { Calendar.current.isDate($0.date, inSameDayAs: GiornoDate) }) { cigarette in
                HStack {
                    Text("\(self.index(of: cigarette, in: self.GiornoDate)).").bold()
                    Spacer()
                    Text("cigarette")
                    Spacer()
                    Text(cigarette.date.formatted(date: .omitted, time: .shortened)).bold()
                }.accessibilityElement(children: .combine)
            }
        }
        .background(
            Rectangle()
                .ignoresSafeArea().frame(height: 1200)
                .foregroundStyle(.linearGradient(colors: [.teal.opacity(0.7), .green.opacity(0.7)], startPoint: .bottom ,endPoint: .top))//.background(Color.white.opacity(0.5))
        )
        .scrollContentBackground(.hidden)
    }
    
    func index(of cigarette: CigaretteData, in date: Date) -> Int {
        // Filter the history for the current day
        let cigarettesForDay = history.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
        
        // Sort cigarettes for the current day by date
        let sortedCigarettesForDay = cigarettesForDay.sorted { $0.date < $1.date }
        
        // Find the index of the current cigarette in the sorted list
        if let index = sortedCigarettesForDay.firstIndex(of: cigarette) {
            return index + 1
        } else {
            return 0
        }
    }
}
