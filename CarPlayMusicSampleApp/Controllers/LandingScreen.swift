//
//  LandingScreen.swift
//  CarPlayMusicSampleApp
//
//  Created by Mahendra Seelam on 8/8/24.
//

import Foundation
import SwiftUI

struct LandingScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Add your logo or image here
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.bottom, 20)
            
            // Add a welcome message or app name
            Text("Shabad Kirtan")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("The best Song app for Kirtans")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            // Add a button to proceed to the main app
            Button(action: {
                // Navigate to the next screen
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct LandingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreenView()
    }
}
