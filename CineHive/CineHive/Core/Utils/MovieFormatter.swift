//
//  MovieFormatter.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import Foundation

struct MovieFormatter {
    static func formatMovieTitle(_ title: String, maxLength: Int = 15) -> String {
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
    
    // 추가된 함수: 날짜 문자열을 Date 객체로 변환
    static func parseReleaseDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        formatter.dateFormat = "yyyy/MM/dd"
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        formatter.dateFormat = "yyyy.MM.dd"
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        // 연도만 있는 경우
        if dateString.count == 4, let year = Int(dateString) {
            var components = DateComponents()
            components.year = year
            components.month = 1
            components.day = 1
            return Calendar.current.date(from: components)
        }
        
        return nil
    }
}
