//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Waihon Yew on 24/04/2022.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)

    }
}

struct ContentView: View {
    static let maxQuestions = 8

    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var score = 0
    @State private var answerCount = 0

    @State private var spinAmount = [0.0, 0.0, 0.0]
    @State private var opacityAmount = [1.0, 1.0, 1.0]
    @State private var scaleAmount = [1.0, 1.0, 1.0]

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)

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
                            FlagImage(imageName: countries[number])
                        }
                        .rotation3DEffect(.degrees(spinAmount[number]), axis: (x: 0, y:1, z:0))
                        .opacity(opacityAmount[number])
                        .scaleEffect(scaleAmount[number])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showingFinalScore) {
            Button("Restart the Game", action: reset)
        } message: {
            Text("Your final score is \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        withAnimation(.linear(duration: 0.5)) {
            for num in 0..<3 {
                if num != number {
                    opacityAmount[num] = 0.25
                    scaleAmount[num] = 0.5
                }
            }
            spinAmount[number] += 360.0
        }

        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong!\nThat's the flag of \(countries[number])."
        }

        answerCount += 1
        // Allow the above animations to be completed first before showing
        // an alert box.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            if (answerCount == Self.maxQuestions) {
                showingFinalScore = true
            } else {
                showingScore = true
            }
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        spinAmount = [0.0, 0.0, 0.0]
        opacityAmount = [1.0, 1.0, 1.0]
        scaleAmount = [1.0, 1.0, 1.0]
    }

    func reset() {
        score = 0
        answerCount = 0

        askQuestion()
    }
}

struct AlertContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {
                print("Now deleting...")
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please read this.")
        }
    }
}

struct ButtonsAndImagesContentView: View {
    var body: some View {
        VStack {
            Button("Delete selection", role: .destructive, action: executeDelete)

            Button("Bordered Button") { }
                .buttonStyle(.bordered)

            Button("Bordered Destructive Button", role: .destructive) { }
                .buttonStyle(.bordered)

            Button("Bordered Prominent Button") { }
                .buttonStyle(.borderedProminent)

            Button("Bordered Prominent Destructive Button", role: .destructive) { }
                .buttonStyle(.borderedProminent)

            Button("Bordered Prominent Tinted Button") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)

            Button {
                print("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundColor(.white)
                    .background(.green)
            }

            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "pencil")
            }
            .buttonStyle(.bordered)

            Button {
                print("Edit button with text was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .buttonStyle(.bordered)
        }
    }

    func executeDelete() {
        print("Now deleting...")
    }
}

struct GradientsContentView: View {
    var body: some View {
        VStack {
            // Linear gradient with an array of colors
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .black]),
                    startPoint: .top, endPoint: .bottom)
                Text("Linear Gradient with an Array of Colors")
                    .foregroundColor(.green)
            }

            // Gradient stops allow us to specify both a color and how far
            // along the gradient the color should be used.
            // For example, we could specify that our gradient should be white
            // from the start up to 35% of the available space, then black from
            // 65% of the available space onwards.
            ZStack {
                LinearGradient(gradient: Gradient(stops: [
                    .init(color: .white, location: 0.35),
                    .init(color: .black, location: 0.65)]),
                    startPoint: .top, endPoint: .bottom)
                Text("Linear Gradient with Stops")
                    .foregroundColor(.yellow)
            }

            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .black]),
                               center: .center, startRadius: 20, endRadius: 150)
                Text("Radial Gradient")
                    .foregroundColor(.white)
            }

            ZStack {
                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                Text("Angular Gradient")
            }
        }
    }
}

struct ColorAndFramesContentView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }

            Text("Your content")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct StacksContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("First")
            Text("Second")
            Text("Third")
            HStack(alignment: .center, spacing: 20) {
                Text("Hello, world!")
                Text("This is inside a stack")
            }
            ZStack(alignment: .top) {
                Text("Hello, world!")
                Text("This is inside a stack")
            }
            Spacer()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //GradientsContentView()
    }
}
