import SwiftUI

struct LazyView<Content: View>: View {
    let viewBuilder: () -> Content
    
    init(_ viewBuilder: @autoclosure @escaping () -> Content) {
        self.viewBuilder = viewBuilder
    }
    
    var body: some View {
        viewBuilder()
    }
}
