//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Imelda Yoon on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userScore = 0
    @State private var count = 0
    @State private var maxCount = 10
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                VStack{
                    Text("Score: \(userScore)")
                    if count < maxCount{
                        Text("Question \(count + 1) out of \(maxCount)")
                    }
                }
                .foregroundStyle(.white)
                .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if count > maxCount {
                Button("Continue", action:
                        reset)
            }
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userScore += 10
            scoreTitle = "Correct!"
        } else {
            userScore -= 5
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
        }
        showingScore = true
        count += 1
        
        if count == maxCount {
            scoreTitle = "Game over!"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if count == maxCount {
            reset()
        }
    }
    
    func reset() {
        count = 0
        userScore = 0
    }
}
#Preview {
    ContentView()
}
