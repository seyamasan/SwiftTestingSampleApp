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
    
    var body: some View {
        NavigationStack {
            VStack {

                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    TextField("Search Repository", text: $query)
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
                
                if (self.viewModel._isSearching) {
                    Spacer()
                    ProgressView()
                        .scaleEffect(2.0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                } else {
                    // List of search results (検索結果リスト)
                    List(self.viewModel._repositories) { repo in
                        NavigationLink {
                            DetailView(repository: repo)
                        } label: {
                            HStack(spacing: 12) {
                                AvatarImage(avatarUrl: repo.owner?.avatarUrl)
                                
                                Text(repo.fullName)
                                    .font(.headline)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 8)
                            .contentShape(Rectangle())
                        }
                    }
                    .scrollDismissesKeyboard(.immediately) // Scrolling hides the keyboard.
                }
            }
            .navigationTitle("GitHub Repository Search")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: .init(
                get: { self.viewModel.errorMessage != nil },
                set: { _ in self.viewModel.errorMessage = nil }
            )) {
                Button("OK") {
                    self.viewModel.errorMessage = nil
                }
            } message: {
                if let errorMessage = self.viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
