//
//  WeatherHomeView.swift
//  WeatherApp
//
//  Created by Karan . on 2/17/23.
//

import SwiftUI

struct WeatherHomeView: View {
    @StateObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(
                    colors: [.blue,Color("lightBlue")],
                    startPoint: .top,
                    endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            WeatherContentVStackView(viewModel: viewModel)
        }
    }

}

struct WeatherContentVStackView: View {
   @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
                ZStack{
                    Text(viewModel.model?.name ?? "Boston, MA")
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 6, x: 1, y: 1)
                        .padding()
                        .scaledToFill()
                        .background(.white.opacity(0.25)).cornerRadius(20)
                }.padding(.top)
                    .padding(.bottom, 40)
            WeatherImageAndTemp(viewModel: viewModel)
            WeatherDetailView(viewModel: viewModel)
            Spacer()
        }
    }
}

struct WeatherDetailView: View {
   @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: 14) {
            Text(viewModel.model?.weather.isEmpty ?? false ? "Sunny" : viewModel.model?.weather.first!.main ?? "Sunny")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .default))
            HStack {
                HStack {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.white)
                    Text("\(viewModel.model?.main.temp_max ?? 0.0, specifier: "%.2f")°F")
                        .foregroundColor(.white)

                }
                HStack {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.white)
                    Text("\(viewModel.model?.main.temp_min ?? 0.0, specifier: "%.2f")°F")
                        .foregroundColor(.white)

                }
            }
        }
       
        
    }
}

struct WeatherImageAndTemp: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: .center)
            // here aspect ration wont work if we add it after frame becuase frame here works for all the previous layer
            // imagine the last mentioned modifier as the base
            Text("\(viewModel.model?.main.temp ?? 0.0, specifier: "%.2f")°F")
                .fontWeight(.bold)
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.white)
        }
        .padding(.bottom, 20)
    }
}


struct DifferentWeatherHView: View {
    var body: some View {
        HStack(spacing: 28) {
            smallWeatherVView(dayOfWeek: "Mon", weatherImageName: "sun.dust.fill", currentTemprature: "76 C")
            smallWeatherVView(dayOfWeek: "Tue", weatherImageName: "cloud.rain.fill", currentTemprature: "66 C")
            smallWeatherVView(dayOfWeek: "Wed", weatherImageName: "cloud.fill", currentTemprature: "70 C")
            smallWeatherVView(dayOfWeek: "Thurs", weatherImageName: "cloud.heavyrain.fill", currentTemprature: "80 C")
            smallWeatherVView(dayOfWeek: "Fri", weatherImageName: "sun.dust.fill", currentTemprature: "62 C")

        }.padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

struct smallWeatherVView: View {
    var dayOfWeek: String
    var weatherImageName: String
    var currentTemprature: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(dayOfWeek)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .regular, design: .default))
            Image(systemName: weatherImageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50, alignment: .center)
            Text(currentTemprature)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .regular, design: .default))
            
        }
    }
}

struct ButtonView: View {
    var body: some View {
        Button {
            print("tapped")
        } label: {
            Text("Change Day Time")
                .frame(width: 200, height: 60, alignment: .center)
                .background(Color(.white))
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundColor(.gray)
                .cornerRadius(12)
        }
        Spacer()
    }
}


struct WeatherHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHomeView(viewModel: WeatherViewModel())
    }
}
