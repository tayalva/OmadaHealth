//
//  Double+Extensions.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let factor = pow(10.0, Double(places))
        return (self * factor).rounded() / factor
    }
}
