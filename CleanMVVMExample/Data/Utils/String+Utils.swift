//
//  String+Utils.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import Foundation

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
