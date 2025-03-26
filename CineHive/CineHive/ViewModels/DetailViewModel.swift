//
//  DetailViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI
import Observation

@Observable
final class DetailViewModel {
    var movieDetail: MovieDetail?
    var isLoading: Bool = false
    var error: String? = nil
    
    // 비디오 재생 관련 상태
    var selectedVideoID: String? = nil
    var showFullScreenVideo: Bool = false
    
    // 탭, 개요 확장 관련 상태
    var selectedTab: DetailTab = .overview
    var isOverviewExpanded: Bool = false
    
    private let movieService: MovieService
    private let movieId: Int

    init(movieId: Int, movieService: MovieService = .shared) {
        self.movieId = movieId
        self.movieService = movieService
        setupVideoNotificationObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @MainActor
    func fetchMovieDetail() {
        performNetworkRequest {
            self.movieDetail = try await self.movieService.fetchMovieDetail(movieId: self.movieId)
        }
    }
    
    func setupVideoNotificationObserver() {
        NotificationCenter.default.addObserver(
            forName: Notification.Name("PlayVideo"),
            object: nil,
            queue: .main
        ) { notification in
            if let videoID = notification.userInfo?["videoID"] as? String {
                self.selectedVideoID = videoID
                self.showFullScreenVideo = true
            }
        }
    }
    
    @MainActor
    private func performNetworkRequest(_ task: @escaping @Sendable () async throws -> Void) {
        Task {
            do {
                isLoading = true
                error = nil
                try await task()
            } catch let error as NetworkError {
                self.error = error.errorDescription
            } catch {
                self.error = "알 수 없는 오류가 발생했습니다."
            }
            isLoading = false
        }
    }
}
