//
//  HomeView.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 13/02/2024.
//

import SwiftUI
import Combine

struct HomeView: View {
  
  // MARK: Stored Properties
  @ObservedObject var coordinator: HomeCoordinator
  @ObservedObject private var viewModel: HomeViewModel
  
  @State var flighNoText: String = ""
  
  init(coordinator: HomeCoordinator) {
    self.coordinator = coordinator
    self._viewModel = ObservedObject(wrappedValue: HomeViewModel())
  }
  
  var body: some View {
    
    VStack {
      Image("flight-status-app-logo")
      
      Spacer()

      TextField(
        "Flight number. Eg: BA0504",
        text: $flighNoText
      )
      .textFieldStyle(.roundedBorder)
      .padding(.leading, CGFloat(50))
      .padding(.trailing, CGFloat(50))
      
      Button(action: {
        viewModel.serviceInitialize(flightNo: flighNoText.uppercased().trimmingCharacters(in: .whitespacesAndNewlines))
      }) {
        Text("Search")
      }.padding()
        .background(Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255))
        .foregroundStyle(.white)
        .clipShape(Capsule())
      
      Spacer()
      Spacer()
    }
  }
        
//    switch viewModel.states {
//    case .ready:
//      VStack {
//        HStack {
//          TextField(
//            "Flight number. Eg: BA2663",
//            text: $flighNoText
//          )
//          .textFieldStyle(.roundedBorder)
//          .textContentType(.emailAddress)
//          .padding(.leading, CGFloat(50))
//          .padding(.trailing, CGFloat(50))
//        }.padding(.top, CGFloat(50))
//
//          Button(action: {
//            viewModel.serviceInitialize(flightNo: flighNoText.uppercased().trimmingCharacters(in: .whitespacesAndNewlines))
//          }) {
//              Text("Search")
//          }
//        Spacer()
//        HistoricDataListView(viewModel: viewModel)
//      }
//    case .error(error: let error):
//      CustomStateView(image: "exclamationmark.transmission",
//                      description: "Something get wrong !",
//                      tintColor: .red)
//        .alert(isPresented: $viewModel.showingAlert) {
//            Alert(title: Text("Error"),
//                  message: Text(error),
//                  dismissButton: Alert.Button.default(
//                    Text("Ok"), action: {
//                        viewModel.changeStateToEmpty()
//                    }
//                  ))
//        }
//    case .finished:
//      CustomStateView(image: "newspaper",
//                      description: "There is data :)",
//                      tintColor: .indigo)
//    case .loading:
//        ProgressView("Loading")
//    case .empty:
//      CustomStateView(image: "newspaper",
//                      description: "There is no data :(",
//                      tintColor: .indigo)
//    }
//    
//    
//  }
}

struct HistoricDataListView: View {
  @State var isloading = false
  @ObservedObject var viewModel: HomeViewModel
    
//  var body: some View {
//    List(viewModel.historicFlightStatusArray) { statusElement in
//      
//      let flightStatus = statusElement.flightStatusArray.first
//      
//      VStack {
//        HStack {
////          AsyncImage(url: statusElement.aircraftURL)
////            .frame(width: 40, height: 40)
////            .cornerRadius(10)
////          let aa = flightStatus?.aircraft.image.url
////          AsyncImage(url: flightStatus?.aircraft.image.url)
////                      .frame(width: 40, height: 40)
////                      .cornerRadius(10)
////          Text(flightStatus?.number ?? "")
////            .font(.headline)
//          Spacer()
//          Text("\(flightStatus?.departure.airport.iata ?? "") - \(flightStatus?.arrival.airport.iata ?? "")")
//            .font(.headline)
//        }
//        
//        HStack {
////          let departureDate = Date.dateFromISOString(flightStatus?.departure.scheduledTime)
//          let ff = viewModel.currentFlightStatus?.timestamp
//          let aaa = flightStatus?.aircraft.image.url
//
////          dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
////          let departureDate = dateFormatter.date(from: flightStatus?.departure.scheduledTime)
//          Text(flightStatus?.status ?? "")
//            .font(.headline)
//          Text(flightStatus?.status ?? "")
//            .font(.headline)
//          Spacer()
//        }
//      }
//    }
//  }
  
  var body: some View {
    VStack {
      Image("flight-status-app-logo")
    }
  }
}

#Preview {
  HomeView(coordinator: HomeCoordinator())
}
