//
//  AvatarImage.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/07.
//

import SwiftUI

// Component to display avatar image of GitHub user from URL
struct AvatarImage: View {
    let avatarUrl: String?
    let size: CGFloat
    
    init(avatarUrl: String?, size: CGFloat = 40) {
        self.avatarUrl = avatarUrl
        self.size = size
    }
    
    var body: some View {
        if let avatarUrlString = avatarUrl,
           let url = URL(string: avatarUrlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: self.size, height: self.size)
                        .clipShape(Circle())
                case .failure(_):
                    self.emptyAvatarView
                case .empty:
                    ProgressView()
                        .frame(width: self.size, height: self.size)
                @unknown default:
                    self.emptyAvatarView
                }
            }
        } else {
            self.emptyAvatarView
        }
    }
    
    private var emptyAvatarView: some View {
        Circle()
            .fill(Color(.systemGray5))
            .frame(width: self.size, height: self.size)
            .overlay(
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.gray)
            )
    }
}

#Preview {
    AvatarImage(avatarUrl: nil)
}
