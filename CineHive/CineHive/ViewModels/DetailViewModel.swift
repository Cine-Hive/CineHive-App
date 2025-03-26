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
    // MARK: - 속성
    
    // UI 상태 관련 변수
    var movieDetail: MovieDetail?
    var isLoading: Bool = true
    var error: String? = nil
    
    // 비디오 재생 관련 상태
    var selectedVideoID: String? = nil
    var showFullScreenVideo: Bool = false
    
    // 탭, 개요 확장 관련 상태
    var selectedTab: DetailTab = .overview
    var isOverviewExpanded: Bool = false
    
    // 서비스 및 상태 변수
    private let movieService: MovieService
    private let movieId: Int
    private var dataLoadingTask: Task<Void, Never>?
    private var skeletonTimerTask: Task<Void, Never>?

    // MARK: - 생명주기
    
    init(movieId: Int, movieService: MovieService = .shared) {
        self.movieId = movieId
        self.movieService = movieService
        setupVideoNotificationObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        dataLoadingTask?.cancel()
        skeletonTimerTask?.cancel()
    }
    
    // MARK: - Public 메소드
    
    /// 영화 데이터 로드 및 스켈레톤 UI 관리
    @MainActor
    func loadData() {
        // 로딩 상태 시작
        isLoading = true
        
        // 기존 작업이 있으면 취소
        dataLoadingTask?.cancel()
        skeletonTimerTask?.cancel()
        
        // 데이터 로딩 작업 시작
        dataLoadingTask = Task { [weak self] in
            guard let self = self else { return }
            
            do {
                // 영화 데이터 요청
                self.movieDetail = try await self.movieService.fetchMovieDetail(movieId: self.movieId)
            } catch let networkError as NetworkError {
                self.error = networkError.errorDescription
            } catch {
                self.error = "알 수 없는 오류가 발생했습니다."
            }
        }
        
        // 최소 1초 동안 스켈레톤 UI를 표시하는 타이머 시작
        skeletonTimerTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 500_000_000) // 1초 대기
            
            guard let self = self, !Task.isCancelled else { return }
            
            // 데이터 로딩이 완료되었는지 확인
            await self.dataLoadingTask?.value
            
            // 로딩 상태 종료
            self.isLoading = false
        }
    }
    
    /// 영화 데이터 다시 로드
    @MainActor
    func refreshData() {
        error = nil
        loadData()
    }
    
    // MARK: - Private 메소드
    
    /// 비디오 알림 옵저버 설정
    private func setupVideoNotificationObserver() {
        NotificationCenter.default.addObserver(
            forName: Notification.Name("PlayVideo"),
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard let self = self else { return }
            
            if let videoID = notification.userInfo?["videoID"] as? String {
                self.selectedVideoID = videoID
                self.showFullScreenVideo = true
            }
        }
    }
}
