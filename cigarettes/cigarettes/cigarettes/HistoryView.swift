//
//  HistoryView.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 18/11/23.
//

import SwiftUI
import SwiftData
import UIKit

struct HistoryView: View {
    
    @Query(sort: \CigaretteData.date) private var history: [CigaretteData]

    var body: some View {
        NavigationStack{
            List{
                ForEach(CigaretteData.uniqueDates(from: history), id: \.self){ item in
                    
                    NavigationLink(
                        destination: CigarettesDetail(GiornoDate: item),
                        label: {
                            Text("\(item.formatted(date: .abbreviated, time: .omitted))")
                        }
                    )
                }
                // .listRowBackground(Color.green.opacity(0.5))
            }
           // .background(.teal).opacity(0.7)
           .background(
                Rectangle().frame(height: 1100)
                    .ignoresSafeArea()
                    .foregroundStyle(.linearGradient(colors: [.teal.opacity(0.7), .green.opacity(0.7)], startPoint: .bottom ,endPoint: .top))//.background(Color.white.opacity(0.4))

            )
            .scrollContentBackground(.hidden)
            .navigationBarTitle("\(monthString) \(year)")
        }
    }
    
    var month: Int{
        let calendar = Calendar.current
        if(!history.isEmpty){
            let months = calendar.component(.month, from: history[history.startIndex].date)
            
            return months
        }
        return 0
    }
    
    func monthName(from month: Int) -> String {
        let formatter = DateFormatter()
        guard (1...12).contains(month) else {
            return " No cigarette yet"
        }
        return formatter.monthSymbols[month - 1]
    }
    
    var monthString: String {
        let month = month
        return monthName(from: month)
    }
    
    var year: String{
        let calendar = Calendar.current
        if(!history.isEmpty){
            let firstDate = history[history.startIndex].date
            let years = calendar.component(.year, from: firstDate)
            return "\(years)"
        }
        return " "
    }
    var dateFormatter:DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
}


#Preview {
    HistoryView()
        
}
