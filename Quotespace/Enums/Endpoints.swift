//
//  Endpoints.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation

enum Endpoints {
    case random
    case today
    
    var path: String {
        switch self {
        case .random:
            "random"
        case .today:
            "today"
        }
    }
}
