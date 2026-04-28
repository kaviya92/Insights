//
//  CardView1.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import SwiftUI
 
struct CardView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .padding(Spacing.md)
//            .background(Color.cardBackground)
            .cornerRadius(16)
//            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
            .background(

                LinearGradient(

                    colors: [

                        Color.white,

                        Color.primaryPurple.opacity(0.05)

                    ],

                    startPoint: .top,

                    endPoint: .bottom

                )

            )

            .overlay(

                RoundedRectangle(cornerRadius: 16)

                    .stroke(Color.purpleBody.opacity(0.08), lineWidth: 1)

            )

            .shadow(color: Color.purpleBody.opacity(0.08), radius: 10, x: 0, y: 6)
             
        
    }
}
