//
//  HomeView.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 13/02/2024.
//

import SwiftUI

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
    

    
    switch viewModel.states {
    case .ready:
      VStack {
        HStack {
          TextField(
            "Flight number. Eg: BA2663",
            text: $flighNoText
          )
          .textFieldStyle(.roundedBorder)
          .textContentType(.emailAddress)
          .padding(.leading, CGFloat(50))
          .padding(.trailing, CGFloat(50))
        }

          Button(action: {
            viewModel.serviceInitialize(flightNo: flighNoText.uppercased().trimmingCharacters(in: .whitespacesAndNewlines))
          }) {
              Text("Search")
          }
      }
    case .error(error: let error):
      CustomStateView(image: "exclamationmark.transmission",
                      description: "Something get wrong !",
                      tintColor: .red)
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Error"),
                  message: Text(error),
                  dismissButton: Alert.Button.default(
                    Text("Ok"), action: {
                        viewModel.changeStateToEmpty()
                    }
                  ))
        }
    case .finished:
      CustomStateView(image: "newspaper",
                      description: "There is data :)",
                      tintColor: .indigo)
    case .loading:
        ProgressView("Loading")
    case .empty:
      CustomStateView(image: "newspaper",
                      description: "There is no data :(",
                      tintColor: .indigo)
    }
    
    
  }
}

#Preview {
  HomeView(coordinator: HomeCoordinator())
}
