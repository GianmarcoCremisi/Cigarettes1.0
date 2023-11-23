//
//  CirculatProgressView.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 15/11/23.
//

import Foundation
import SwiftUI
import SwiftData


struct CircularProgressView: View {    
    @Environment(\.modelContext) private var context
    @Binding var count: Double 
    var body: some View {
        ZStack {
            // Gray circle
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(.white.opacity(0.3))
                .frame(width: 300)
             // Foreground circle
            Circle()
                .trim(from: 0.0, to:  count/Double(50))
                .stroke(style: StrokeStyle(lineWidth: 20.0,
                    lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 300)
        }
        .animation(Animation.linear(duration: 0.5), value: count)
    }
}
