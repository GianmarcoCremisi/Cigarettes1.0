//
//  ContentView.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 15/11/23.
//

import Foundation
import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("circle.progres") var count: Double = 0
    @Environment(\.modelContext) private var context
    @Query(sort: \CigaretteData.date) private var history: [CigaretteData]
    
    
    @State private var tempoTrascorso: TimeInterval = 0.0
    @State private var isRunning = false
    @State private var timer: Timer?
    
    @State private var tempoFormattato: String = " "

    var body: some View {
        VStack{
            VStack{
                Text("Since your last cigarette has been")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.top, 20)
                    .opacity(0.8)
                Text("\(tempoFormattato)")
                    .font(.largeTitle)
                    .foregroundStyle(.white.opacity(0.8))
                    .onAppear {
                        self.startTimer()
                    }
                    .padding(.top, 7)
            }.accessibilityElement(children: .combine)
            
            Spacer()
            ZStack{
                CircularProgressView(count: $count).frame(width: 400)
                VStack{
                    Text(String(format: "%.0f" ,count)).font(.system(size: 70)).fontWeight(.medium).foregroundStyle(.white).accessibilityLabel(Text(String(format: "%.0f cigarettes" ,count)))
                        .onAppear {
                            if !Calendar.current.isDateInToday(history.last?.date ?? Date()) {
                                count = 0
                            }
                        }
                }
                
            }
            Spacer()
            Button(action: {
                count += 1
                if self.isRunning {
                    self.stopTimer()
                    self.startTimer()
                } else {
                    self.startTimer()
                }
                context.insert(CigaretteData(date: Date()))
            }, label: {
                Image(systemName: "plus.circle").font(.system(size: 75)).foregroundStyle(.white).padding(.bottom, 50)
            })
        }
        .background(
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.linearGradient(colors: [.teal.opacity(0.7), .green.opacity(0.7)], startPoint: .bottom, endPoint: .top))
        )
        .scaledToFill()
    }
    
    
 
    func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                let interval = Int(Date().timeIntervalSince(history.last?.date ?? Date()))
                let seconds = interval % 60
                let minutes = (interval / 60) % 60
                let hours = interval / 3600
                tempoFormattato = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
            isRunning = true
        }
    
    func stopTimer() {
        timer?.invalidate()
        self.tempoTrascorso = 0.0
        timer = nil
        isRunning = false
    }
    func additem(){
        let item = CigaretteData(date: Date())
        context.insert(item)
    }
}

#Preview {
    ContentView()
}
