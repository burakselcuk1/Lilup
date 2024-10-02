//
//  TextFileViewModel.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 02.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import SwiftUI

class TextFileViewModel: ObservableObject {
    @Published public var data: LocalizedStringKey = ""
    
    init(_ filename: String) { self.load(file: filename) }
    
    func load(file: String) {
        if let filepath = Bundle.main.path(forResource: file, ofType: "md") {
            do {
                let contents = try String(contentsOfFile: filepath)
                DispatchQueue.main.async {
                    self.data = LocalizedStringKey(contents)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("File not found")
        }
    }
}
