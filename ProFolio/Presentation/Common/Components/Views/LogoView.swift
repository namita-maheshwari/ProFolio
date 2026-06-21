//
//  LogoView.swift
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.10, green: 0.17, blue: 0.30),
                                                     Color(red: 0.05, green: 0.10, blue: 0.20)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                .frame(width: 120, height: 120)
            
            // Briefcase shape (stylized "P")
            VStack(spacing: -8) {
                // Top handle of briefcase (also forms the loop of "P")
                Capsule()
                    .fill(Color(red: 0.96, green: 0.65, blue: 0.14)) // gold accent
                    .frame(width: 40, height: 8)
                    .offset(y: -4)
                
                // Main body (vertical bar of "P")
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 32, height: 50)
                    .cornerRadius(4)
                    .overlay(
                        // Decorative horizontal line simulating folder/document
                        Rectangle()
                            .fill(Color(red: 0.96, green: 0.65, blue: 0.14))
                            .frame(width: 24, height: 3)
                            .offset(x: -4, y: 0),
                        alignment: .leading
                    )
                    .overlay(
                        Rectangle()
                            .fill(Color(red: 0.96, green: 0.65, blue: 0.14))
                            .frame(width: 24, height: 3)
                            .offset(x: -4, y: 12),
                        alignment: .leading
                    )
            }
            .offset(y: 4) // center the shape
        }
        .frame(width: 120, height: 120)
    }
}

// MARK: - Preview
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}
