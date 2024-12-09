//
//  ContentView.swift
//  aoc24
//
//  Created by Francesco Puglisi on 04.12.24.
//

import SwiftUI

struct ContentView: View {
    let model = AoCModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(model.result)")
        }
        .padding()
        .onAppear {
            Task {
                let clock = ContinuousClock()
                let result = clock.measure(model.perform)
                print(result)
            }
        }
    }
}

#Preview {
    ContentView()
}
