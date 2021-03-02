//
//  Array+Utils.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import Foundation

extension Array {
    func item(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
