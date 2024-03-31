import SwiftUI

extension Date {
    /// Convert a date to a string with a given format
    /// - Parameter format: String
    /// - Returns: String
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }   
}
