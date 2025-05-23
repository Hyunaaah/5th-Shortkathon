

import Foundation
import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    var imageName: String
    var title: String
    var author: String
}
