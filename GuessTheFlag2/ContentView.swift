//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Waihon Yew on 24/04/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Linear gradient with an array of colors
            LinearGradient(gradient: Gradient(colors: [.white, .black]),
                startPoint: .top, endPoint: .bottom)

            // Gradient stops allow us to specify both a color and how far
            // along the gradient the color should be used.
            // For example, we could specify that our gradient should be white
            // from the start up to 35% of the available space, then black from
            // 65% of the available space onwards.
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .white, location: 0.35),
                .init(color: .black, location: 0.65)]),
                startPoint: .top, endPoint: .bottom)

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
    }
}
