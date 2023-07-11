import SwiftUI

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    /// Hide or show the view based on an optional value.
    ///
    /// - Parameters:
    ///   - hidden: Set to non `nil` value to show the view. Set to `nil` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Optional<Any>, remove: Bool = false) -> some View {
        if hidden == nil {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
