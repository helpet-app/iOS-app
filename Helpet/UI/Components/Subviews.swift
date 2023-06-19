//
//  Subviews.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.01.2023.
//

import SwiftUI

struct Subviews<Content: View, ViewsContent: View>: View {
    let content: () -> Content

    let views: (Views) -> ViewsContent

    init(of content: Content, views: @escaping (Views) -> ViewsContent) {
        self.content = { content }
        self.views = views
    }

    init(content: @escaping () -> Content, views: @escaping (Views) -> ViewsContent) {
        self.content = content
        self.views = views
    }

    var body: some View {
        _VariadicView.Tree(UnaryViewRoot(views: views), content: content)
    }
}

extension Subviews {
    private struct UnaryViewRoot<Content: View>: _VariadicView_UnaryViewRoot {
        let views: (Views) -> Content

        func body(children: Views) -> some View {
            views(children)
        }
    }
}

typealias Views = _VariadicView.Children
