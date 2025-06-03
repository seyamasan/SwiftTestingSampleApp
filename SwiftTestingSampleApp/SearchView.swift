//
//  SearchView.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import SwiftUI

struct SearchView: View {
    
    @State var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            Task {
                await viewModel.searchRepositories(quely: "seyamasan")
            }
        }
    }
}

#Preview {
    SearchView()
}
