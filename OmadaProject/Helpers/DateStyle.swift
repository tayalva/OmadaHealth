//
//  DateStyle.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import Foundation

/// A helper enum for formatting dates either as a year or a full long-style date.
enum DateStyle {
    case year(Date?)
    case full(Date?)
    
    var formattedString: String {
        let dateFormatter = DateFormatter()
        
        switch self {
        case .year(let date):
            guard let date else { return "" }
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter.string(from: date)
        case .full(let date):
            guard let date else { return "" }
            dateFormatter.dateStyle = .long
            return dateFormatter.string(from: date)
        }
    }
}
