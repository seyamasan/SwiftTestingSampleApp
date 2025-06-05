//
//  SearchView.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/03.
//

import SwiftUI

struct SearchView: View {
    
    @State private var viewModel: SearchViewModel = DIContainer.shared.makeSearchViewModel()
    @State private var query: String = ""
    
    @FocusState var focus: Bool
        
    var body: some View {
        NavigationStack {
            VStack {

                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    TextField("Search Repository", text: $query)
                        .focused(self.$focus)
                        .submitLabel(.search)
                        .onSubmit {
                            Task {
                                await self.viewModel.searchRepositories(query: query)
                            }
                        }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                )
                .frame(width: UIScreen.main.bounds.width * 0.8)

                // List of search results (検索結果リスト)
                List(self.viewModel._repositories) { repo in
                    VStack(alignment: .leading) {
                        Text(repo.fullName)
                            .font(.headline)
                    }
                }
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        // Tap the screen to unfocus the keyboard. (画面タップでキーボードのフォーカスを外す)
                        self.focus = false
                    }
            )
            .navigationTitle("GitHub Repository Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
