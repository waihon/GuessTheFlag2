//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Waihon Yew on 24/04/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Text("Your content")
        }
        .background(.red)
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
