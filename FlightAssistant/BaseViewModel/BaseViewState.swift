//
//  BaseViewState.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 08/04/2024.
//

import Foundation
 
protocol ViewStateProtocol {
    static var ready: Self { get }
}

protocol ViewStatable {
    associatedtype ViewState: ViewStatable = DefaultViewState
}

enum DefaultViewState: ViewStateProtocol {
    case ready
}

