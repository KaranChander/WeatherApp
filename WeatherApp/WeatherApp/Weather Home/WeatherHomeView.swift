//
//  WeatherHomeView.swift
//  WeatherApp
//
//  Created by Karan . on 2/17/23.
//

import SwiftUI

struct WeatherHomeView: View {
    @State var searchText: String
    @StateObject var viewModel: WeatherViewModel
    @State var isExpanded: Bool = false

    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(
                    colors: viewModel.getBackgroundGradientColors(icon: viewModel.model?.weather.first!.icon ?? .clearSkyDay),
                    startPoint: .top,
                    endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                WeatherContentVStackView(viewModel: viewModel, searchText: $searchText, isExpanded: $isExpanded)
                CityListView(searchText: $searchText, viewModel: viewModel, isExpanded: $isExpanded)
                    .edgesIgnoringSafeArea(.top)
                    .padding(.top, -320)
                
                
            }
        }.navigationBarBackButtonHidden(true)
            .preferredColorScheme(.light)

    }
    
}

struct CityListView: View {
    @Binding var searchText: String
    @ObservedObject var viewModel: WeatherViewModel
    @FocusState private var isTextFieldFocused: Bool
    @Binding var isExpanded: Bool
    var cities: [City] {
        //        let allCities = viewModel.cityArray.map{$0.name.lowercased()}
        return viewModel.cityArray.filter { city in
            return city.city.lowercased().contains(searchText.lowercased())
        }
    }
    var body: some View {
        List() {
            
            ForEach(cities) { city in
                Text(city.city)
                    .onTapGesture {
                        viewModel.fetchWeatherAPI(lat: city.latitude, long: city.longitude)
                        searchText = ""
                        isExpanded = false
                    }
            }
        }.opacity(1)
            .listStyle(.inset)
            .listRowBackground(Color.clear)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .frame(height: searchText.isEmpty ? 0 : 300)
            .onAppear() {
                             UITableView.appearance().backgroundColor = UIColor.clear
                             UITableViewCell.appearance().backgroundColor = UIColor.clear
                         }
            
//            .cornerRadius(20)
            
    }
}

struct WeatherContentVStackView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Binding var searchText: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack {
            SearchContainerView(query: $searchText, isExpanded: $isExpanded, viewModel: viewModel)
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
            Image(systemName: viewModel.getWeatherIcon(icon: viewModel.model?.weather.first!.icon ?? .clearSkyDay ))
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

// have a search bar hidden and when we tap on button the view is gonna expand and after that this expnaded view will hide and the hidden view will be revealed with keyboard open to search

struct SearchContainerView: View {
    @Binding var query: String
    @Binding var isExpanded: Bool
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            
            StretchView(isExpanded: $isExpanded)
            SearchBarView(searchText: $query, isExpanded: $isExpanded, viewModel: viewModel)
                .opacity(1)
            
        }
        
    }
}

struct StretchView: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .opacity(0.3)
                .cornerRadius(25)
                .frame(width: isExpanded ? UIScreen.main.bounds.width - 40 : 50, height: 50)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        print("Animation finished")
                    }
                }
            
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
            Image(systemName: isExpanded ? "xmark.circle": "magnifyingglass")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 34)
        }
    }
}


struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isExpanded: Bool
    @ObservedObject var viewModel: WeatherViewModel

    
    var body: some View {
        
        
        ZStack {
            TextField("Search city", text: $searchText)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .padding(.horizontal, 10)
                .padding(.leading, 20)
                .padding(.trailing, 60)
                .opacity(isExpanded ? 1 : 0)
        }
    }
}



struct WeatherHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHomeView(searchText: "bo", viewModel: WeatherViewModel())
    }
}

