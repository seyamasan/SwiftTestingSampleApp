//
//  DetailView.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/07.
//

import SwiftUI

struct DetailView: View {
    let repository: GitHubRepo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Avater Icon
                AvatarImage(
                    avatarUrl: self.repository.owner?.avatarUrl,
                    size: 200
                )
                .frame(maxWidth: .infinity)
                
                // Repository Info
                VStack(alignment: .leading, spacing: 12) {
                    Text(self.repository.fullName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let language = self.repository.language {
                        HStack {
                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                            Text(language)
                        }
                        .foregroundColor(.secondary)
                    }
                    
                    // Stats
                    HStack(spacing: 16) {
                        StatView(
                            value: self.repository.stargazersCount,
                            iconName: "star.fill",
                            label: "Stars"
                        )
                        StatView(
                            value: self.repository.watchersCount,
                            iconName: "eye.fill",
                            label: "Watchers"
                        )
                        StatView(
                            value: self.repository.forksCount,
                            iconName: "tuningfork",
                            label: "Forks"
                        )
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct StatView: View {
    let value: Int
    let iconName: String
    let label: String
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Image(systemName: iconName)
                Text("\(value)")
            }
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    DetailView(
        repository: GitHubRepo(
            fullName: "seyamasan/seyamasan",
            language: nil,
            owner: GitHubRepo.Owner(avatarUrl: ""),
            stargazersCount: 1234,
            watchersCount: 567,
            forksCount: 890,
            openIssuesCount: 123
        )
    )
}
