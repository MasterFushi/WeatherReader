//
//  WeatherDisplay.swift
//  WeatherReader
//
//  Created by Nevin Gregory on 5/26/20.
//  Copyright © 2020 Nevin Gregory. All rights reserved.
//

import SwiftUI

struct WeatherDisplay: View {
    
    var wArray = DataReader.wArray
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(0..<wArray.count)
                { item in
                    Text("\( self.wArray[item].dateString)\n\(self.wArray[item].temp)°F\n\(self.wArray[item].summary)").foregroundColor(.white)
                        .frame(width: 200, height: 200)
                        .background(Color.blue)
                }
            }
        }
    }
}


struct WeatherDisplay_Previews: PreviewProvider {
    
    static var previews: some View {
        WeatherDisplay()
    }
}
