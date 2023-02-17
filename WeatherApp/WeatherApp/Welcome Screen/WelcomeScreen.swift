//
//  ContentView.swift
//  WeatherApp
//
//  Created by Karan . on 2/16/23.
//

import SwiftUI

struct WelcomeScreen: View {

    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
        ZStack {
            LinearGradient(
                    colors: [.blue,Color("lightBlue")],
                    startPoint: .top,
                    endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack{
                locationLabelView()
                    .padding()
                locationButtonView(locationManager: locationManager)
            }
            
        }
        }
    }
}

struct locationButtonView: View {
    
    var locationManager: LocationManager
    @State var selection: Int? = nil

    var body: some View {
        NavigationLink(destination: WeatherHomeView(viewModel: WeatherViewModel(coordinates: locationManager.location!)), tag: 1, selection: $selection) {
                ZStack {
                    Color(.gray)
                        .frame(width: 250, height: 40, alignment: .center)
                        .cornerRadius(20)
                        .opacity(0.3)
                    Button {
                        //prompt for location
                        locationManager.requestLocation()
                        print(locationManager.location)
                        self.selection = 1
                    } label: {
                        Image(systemName: "location.fill")
                            .tint(.white)
                        Text("Allow Location Permission")
                            .foregroundColor(.white)
                    }.padding(EdgeInsets.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                        
                        
                }
            }
        
       
    }
}

struct locationLabelView: View {
    var body: some View {
       Text("Please allow location to see your personalised weather report!")
            .foregroundColor(.white)
            .font(Font.system(size: 16, weight: .bold, design: .default))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
