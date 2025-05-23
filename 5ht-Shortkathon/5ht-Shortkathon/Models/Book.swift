//
//  Book.swift
//  5ht-Shortkathon
//
//  Created by 주현아 on 5/24/25.
//

import Foundation
import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    var imageName: String 
    var title: String
    var author: String
}
