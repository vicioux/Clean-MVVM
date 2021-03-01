//
//  TestDefaulCoctailRepository.swift
//  CleanMVVMExampleTests
//
//  Created by Sergio Orozco  on 1/03/21.
//

import XCTest

class TestDefaulCoctailRepository: XCTestCase {
    
    
    func testFetchCoctailList() {
        let expectation = self.expectation(description: "testFetchCoctailList")
        
        let nsm = DefaultNetworkSessionManager()
        let ns = DefaultNetworkService(sessionManager: nsm)
        let dataError = DefaultDataTransferErrorResolver()
        let dataTransfer = DefaultDataTransferService(with: ns, errorResolver: dataError)
        
        let request = APIEndpoints().getCoctailList(queryParameters: ["s": "margarita"])
        
        dataTransfer.request(with: request) { result in
            print(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
}


