//
//  MovieFormatter.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import Foundation

struct MovieFormatter {
    static func formatMovieTitle(_ title: String, maxLength: Int = 25) -> String {
        guard title.count > maxLength else { return title }
        return String(title.prefix(maxLength - 3)) + "..."
    }
    
    static func formatMovieGenres(_ genres: [String], limit: Int = 2) -> String {
        return Array(genres.prefix(limit)).joined(separator: " • ")
    }
    
    static func extractMovieYear(from dateString: String) -> String {
        guard dateString.count >= 4 else { return dateString }
        return String(dateString.prefix(4))
    }
    
    static func generateMovieRating(for movie: Movie) -> String {
        let baseRating = 7.0
        let variation = Double(movie.id % 30) / 10
        let rating = baseRating + variation
        return String(format: "%.1f", rating)
    }
}
