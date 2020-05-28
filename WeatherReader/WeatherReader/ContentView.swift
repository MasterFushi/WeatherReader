//
//  ContentView.swift
//  WeatherReader
//
//  Created by Nevin Gregory on 5/25/20.
//  Copyright © 2020 Nevin Gregory. All rights reserved.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        NavigationView {
            VStack() {
                Text("Annapolis, MD")
                WeatherDisplay()
                Spacer()
            }.navigationBarTitle("Hourly Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
