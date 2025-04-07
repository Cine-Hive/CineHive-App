//
//  GenreBrowserViewModel.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import Foundation
import SwiftUI

@Observable
final class GenreBrowserViewModel {
    private(set) var isLoading = false
    private(set) var error: String?
    private(set) var selectedGenre: String? = "액션"
    
    // 장르 리스트
    let genres = ["액션", "모험", "코미디", "드라마", "SF", "판타지", "공포", "로맨스", "스릴러", "애니메이션"]
    
    // 실제 ID와 이름 매핑을 위한 장르 맵
    private let genreIdMap: [String: Int] = [
        "액션": 28,
        "모험": 12,
        "애니메이션": 16,
        "코미디": 35,
        "범죄": 80,
        "다큐멘터리": 99,
        "드라마": 18,
        "가족": 10751,
        "판타지": 14,
        "역사": 36,
        "공포": 27,
        "음악": 10402,
        "미스터리": 9648,
        "로맨스": 10749,
        "SF": 878,
        "TV 영화": 10770,
        "스릴러": 53,
        "전쟁": 10752,
        "서부": 37
    ]
    
    private let movieService: MovieService
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    // 장르 선택 처리
    func selectGenre(_ genre: String) {
        withAnimation {
            if selectedGenre == genre {
                selectedGenre = nil
            } else {
                selectedGenre = genre
            }
        }
    }
    
    // 선택된 장르에 대한 영화 가져오기
    func getMoviesForSelectedGenre() -> [Movie] {
        guard let genre = selectedGenre else { return [] }
        
        // 더미 데이터에서 장르에 맞는 영화 가져오기
        return Movie.genreMovies[genre] ?? []
    }
    
    // 영화 평점 생성
    func generateRating(for movie: Movie) -> String {
        return MovieFormatter.generateMovieRating(for: movie)
    }
    
    // 실제 API 호출 메소드 (향후 사용)
    @MainActor
    func fetchMoviesByGenre(_ genre: String) async {
        guard let genreId = genreIdMap[genre] else { return }
        
        do {
            isLoading = true
            error = nil
            
            // API 구현 시 아래 주석 해제
            // let movies = try await movieService.fetchMoviesByGenre(genreId: genreId)
            // TODO: 가져온 영화 데이터 처리
            
            // 임시 딜레이
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
}
