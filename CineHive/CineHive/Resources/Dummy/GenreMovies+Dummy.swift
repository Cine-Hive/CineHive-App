//
//  GenreMovies+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/24/25.
//

//
//  GenreMovies+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/24/25.
//

import Foundation

// MARK: - 장르별 영화 더미 데이터
extension Movie {
    // 액션 영화
    static var actionMovie1 = Movie(id: 201, posterPath: "/xiLFc0hW0XIpzJ0D4jkI.jpg", backDropPath: "/4woSOUD0equAYzvwhWBHIJDCM88.jpg")
    static var actionMovie2 = Movie(id: 202, posterPath: "/qW4crfED8mpNDadSmMdi7ZDzhXF.jpg", backDropPath: "/jXJxMcVoEuXzql3lXPi7jmdUCck.jpg")
    static var actionMovie3 = Movie(id: 203, posterPath: "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", backDropPath: "/t7I942V5U1Fbxri3L7of6vTVSCTx.jpg")
    static var actionMovie4 = Movie(id: 204, posterPath: "/3UPXQtdWLdHAjcaFwCGwMN9CTJj.jpg", backDropPath: "/4HWAQu28e2yaWrtupFPGFkdNU7V.jpg")
    static var actionMovies: [Movie] {
        return [actionMovie1, actionMovie2, actionMovie3, actionMovie4]
    }
    
    // 모험 영화
    static var adventureMovie1 = Movie(id: 301, posterPath: "/6WR7wLCX0PGLhj51qyvK8SIJXTm.jpg", backDropPath: "/628Dep6AxEtDxjZoGP78TsOxYbK.jpg")
    static var adventureMovie2 = Movie(id: 302, posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", backDropPath: "/j9GXPw4C2v0b7nJp5OXwKf2pM3C.jpg")
    static var adventureMovie3 = Movie(id: 303, posterPath: "/c0C14eahXRmP9wC6OWxzYK7MiwV.jpg", backDropPath: "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg")
    static var adventureMovie4 = Movie(id: 304, posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg", backDropPath: "/etJCz1P28P03PQDGfWweGYNOvxE.jpg")
    static var adventureMovies: [Movie] {
        return [adventureMovie1, adventureMovie2, adventureMovie3, adventureMovie4]
    }
    
    // 코미디 영화
    static var comedyMovie1 = Movie(id: 401, posterPath: "/lTZ3sOlJkWz0qPMPFQDLLHhl0N1.jpg", backDropPath: "/wjCjgxOlz84Q7xjdBo39MpZjmKs.jpg")
    static var comedyMovie2 = Movie(id: 402, posterPath: "/AgVX0MUzOOVeDglVDX7TGX8MgZB.jpg", backDropPath: "/yqVSGO7VCFVeZ8VRzHRV7Shy2Zl.jpg")
    static var comedyMovie3 = Movie(id: 403, posterPath: "/2LqaLgk4Z226YVIj4TerQXsQANd.jpg", backDropPath: "/zIYROrkHJPYB3VTiW1L9QVgaQO.jpg")
    static var comedyMovie4 = Movie(id: 404, posterPath: "/uBZQOYZLIU9dBMsGEJgwQkIqrJm.jpg", backDropPath: "/zU7KO9ivGBAb45LyGSf3lit7Fob.jpg")
    static var comedyMovies: [Movie] {
        return [comedyMovie1, comedyMovie2, comedyMovie3, comedyMovie4]
    }
    
    // 드라마 영화
    static var dramaMovie1 = Movie(id: 501, posterPath: "/hJfI6AGrmr4uSHRccfJuSsapvOb.jpg", backDropPath: "/5YZbUmjbMa3ClvSW1Wj3D6XGolb.jpg")
    static var dramaMovie2 = Movie(id: 502, posterPath: "/67I1nZB4BlNS33QlLkoPgpXY7r0.jpg", backDropPath: "/rzdPqYx7Um4FUZeD8wpXqjAUcEm.jpg")
    static var dramaMovie3 = Movie(id: 503, posterPath: "/4KV8GTqiKIU04XzAGQl7cEyIHEQ.jpg", backDropPath: "/jZIYaISP3GBSrVOPfrp98AMa8Ng.jpg")
    static var dramaMovie4 = Movie(id: 504, posterPath: "/h0ZzIaUGwuAnwDvuVGXhVKYdXQi.jpg", backDropPath: "/sD8YFq4J8lujQrGSkQFBQpbjeQX.jpg")
    static var dramaMovies: [Movie] {
        return [dramaMovie1, dramaMovie2, dramaMovie3, dramaMovie4]
    }
    
    // SF 영화
    static var sciFiMovie1 = Movie(id: 601, posterPath: "/mDkPrBShQYu9fp0Z66tQwYyWQUa.jpg", backDropPath: "/ye9NFQvdzX6iBmDx3dRhxJtGxn6.jpg")
    static var sciFiMovie2 = Movie(id: 602, posterPath: "/ArWn6gCi61b3b3hclD2L0LOk66k.jpg", backDropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg")
    static var sciFiMovie3 = Movie(id: 603, posterPath: "/t6HIqrRAclMzcQm5ynoNekJtgxY.jpg", backDropPath: "/3t0DcVPuW9JRtc1CWnh1XiB5Kr3.jpg")
    static var sciFiMovie4 = Movie(id: 604, posterPath: "/zDbMT3lzrUMXaZPpGQCpJdoJWGE.jpg", backDropPath: "/7SRUKTRnXGGDVZVqNNOtUl46DCz.jpg")
    static var sciFiMovies: [Movie] {
        return [sciFiMovie1, sciFiMovie2, sciFiMovie3, sciFiMovie4]
    }
    
    // 판타지 영화
    static var fantasyMovie1 = Movie(id: 701, posterPath: "/bKDUvlSc5bCCpbWt0JHJvkQUXbk.jpg", backDropPath: "/rlQrqDraVMiX46XVpEUelYkLEHu.jpg")
    static var fantasyMovie2 = Movie(id: 702, posterPath: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg", backDropPath: "/loRmLlvoeyccB2JjLrUYzQuvJBv.jpg")
    static var fantasyMovie3 = Movie(id: 703, posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg", backDropPath: "/sAtoMqDVhNDQBc3QJL3RF6hlhGq.jpg")
    static var fantasyMovie4 = Movie(id: 704, posterPath: "/gB05Mzo1YZ48ffrfVoY3i96tQ7u.jpg", backDropPath: "/cYlHLJdYpPMOeGnrHd1yLfj8lOF.jpg")
    static var fantasyMovies: [Movie] {
        return [fantasyMovie1, fantasyMovie2, fantasyMovie3, fantasyMovie4]
    }
    
    // 공포 영화
    static var horrorMovie1 = Movie(id: 801, posterPath: "/aNE75MIMjMFUhMpULI7nIk8ymR.jpg", backDropPath: "/uJR7oprHMQE9Ddf5KBrYYUQKN7Z.jpg")
    static var horrorMovie2 = Movie(id: 802, posterPath: "/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg", backDropPath: "/8NEvnVKeGMLEXG45MMFy5NrgvOb.jpg")
    static var horrorMovie3 = Movie(id: 803, posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg", backDropPath: "/etJCz1P28P03PQDGfWweGYNOvxE.jpg")
    static var horrorMovie4 = Movie(id: 804, posterPath: "/2xPqTGY5xM7qLdaSRFD5KdZtHXT.jpg", backDropPath: "/14QbnygCuTO0vl7CAFmPf1fgZfV.jpg")
    static var horrorMovies: [Movie] {
        return [horrorMovie1, horrorMovie2, horrorMovie3, horrorMovie4]
    }
    
    // 로맨스 영화
    static var romanceMovie1 = Movie(id: 901, posterPath: "/cRdA9xjHBbobw4LJFsQ3j1CgpVq.jpg", backDropPath: "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")
    static var romanceMovie2 = Movie(id: 902, posterPath: "/m7tG5E1EbywuwTsl6hq990So0dZ.jpg", backDropPath: "/gJESrIalPbvb4CHWC9NtJHH1JxF.jpg")
    static var romanceMovie3 = Movie(id: 903, posterPath: "/f20XgJmFqGZCj2Z0nTJPVnCOLEV.jpg", backDropPath: "/2D6ksPSChcRcFbQVQFFYIUmerl.jpg")
    static var romanceMovie4 = Movie(id: 904, posterPath: "/5Bchgfx0PzxHZVaIq3QubTRuOP8.jpg", backDropPath: "/d4qx8Aep9n1YyHMkQxPQYlpOtP4.jpg")
    static var romanceMovies: [Movie] {
        return [romanceMovie1, romanceMovie2, romanceMovie3, romanceMovie4]
    }
    
    // 스릴러 영화
    static var thrillerMovie1 = Movie(id: 1001, posterPath: "/feSiIcs8zWqiuPHXJkxZykmhSvo.jpg", backDropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg")
    static var thrillerMovie2 = Movie(id: 1002, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var thrillerMovie3 = Movie(id: 1003, posterPath: "/qhb1qOilapbapxWQn9jtRCL7hCo.jpg", backDropPath: "/pWsRU3EHLpGGiVx2xKUMu6r5haq.jpg")
    static var thrillerMovie4 = Movie(id: 1004, posterPath: "/xcFulWM3KPT8RRjgEsCWYHG9nxr.jpg", backDropPath: "/amiCH0omIGiuQ0Zz0qfLKGKnSJ0.jpg")
    static var thrillerMovies: [Movie] {
        return [thrillerMovie1, thrillerMovie2, thrillerMovie3, thrillerMovie4]
    }
    
    // 애니메이션 영화
    static var animationMovie1 = Movie(id: 1101, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var animationMovie2 = Movie(id: 1102, posterPath: "/exNtEY8QUuQh9e23wBQYeCFpXiU.jpg", backDropPath: "/mDeUmPe4MF35WWlAqj4QFX5UDeO.jpg")
    static var animationMovie3 = Movie(id: 1103, posterPath: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg", backDropPath: "/eSVu1FvGPy86TDo4hQbpuHx55DJ.jpg")
    static var animationMovie4 = Movie(id: 1104, posterPath: "/w4c0GTpmEQ1CZQNHndTv2t7AMzj.jpg", backDropPath: "/xi7kBe6ZgbHfiRs2rYbqraa1nJV.jpg")
    static var animationMovies: [Movie] {
        return [animationMovie1, animationMovie2, animationMovie3, animationMovie4]
    }
    
    // 범죄 영화
    static var crimeMovie1 = Movie(id: 1201, posterPath: "/4KV8GTqiKIU04XzAGQl7cEyIHEQ.jpg", backDropPath: "/jZIYaISP3GBSrVOPfrp98AMa8Ng.jpg")
    static var crimeMovie2 = Movie(id: 1202, posterPath: "/h0ZzIaUGwuAnwDvuVGXhVKYdXQi.jpg", backDropPath: "/sD8YFq4J8lujQrGSkQFBQpbjeQX.jpg")
    static var crimeMovie3 = Movie(id: 1203, posterPath: "/feSiIcs8zWqiuPHXJkxZykmhSvo.jpg", backDropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg")
    static var crimeMovie4 = Movie(id: 1204, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var crimeMovies: [Movie] {
        return [crimeMovie1, crimeMovie2, crimeMovie3, crimeMovie4]
    }
    
    // 다큐멘터리 영화
    static var documentaryMovie1 = Movie(id: 1301, posterPath: "/qhb1qOilapbapxWQn9jtRCL7hCo.jpg", backDropPath: "/pWsRU3EHLpGGiVx2xKUMu6r5haq.jpg")
    static var documentaryMovie2 = Movie(id: 1302, posterPath: "/xcFulWM3KPT8RRjgEsCWYHG9nxr.jpg", backDropPath: "/amiCH0omIGiuQ0Zz0qfLKGKnSJ0.jpg")
    static var documentaryMovie3 = Movie(id: 1303, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var documentaryMovie4 = Movie(id: 1304, posterPath: "/exNtEY8QUuQh9e23wBQYeCFpXiU.jpg", backDropPath: "/mDeUmPe4MF35WWlAqj4QFX5UDeO.jpg")
    static var documentaryMovies: [Movie] {
        return [documentaryMovie1, documentaryMovie2, documentaryMovie3, documentaryMovie4]
    }
    
    // 가족 영화
    static var familyMovie1 = Movie(id: 1401, posterPath: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg", backDropPath: "/eSVu1FvGPy86TDo4hQbpuHx55DJ.jpg")
    static var familyMovie2 = Movie(id: 1402, posterPath: "/w4c0GTpmEQ1CZQNHndTv2t7AMzj.jpg", backDropPath: "/xi7kBe6ZgbHfiRs2rYbqraa1nJV.jpg")
    static var familyMovie3 = Movie(id: 1403, posterPath: "/4KV8GTqiKIU04XzAGQl7cEyIHEQ.jpg", backDropPath: "/jZIYaISP3GBSrVOPfrp98AMa8Ng.jpg")
    static var familyMovie4 = Movie(id: 1404, posterPath: "/h0ZzIaUGwuAnwDvuVGXhVKYdXQi.jpg", backDropPath: "/sD8YFq4J8lujQrGSkQFBQpbjeQX.jpg")
    static var familyMovies: [Movie] {
        return [familyMovie1, familyMovie2, familyMovie3, familyMovie4]
    }
    
    // 역사 영화
    static var historyMovie1 = Movie(id: 1501, posterPath: "/feSiIcs8zWqiuPHXJkxZykmhSvo.jpg", backDropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg")
    static var historyMovie2 = Movie(id: 1502, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var historyMovie3 = Movie(id: 1503, posterPath: "/qhb1qOilapbapxWQn9jtRCL7hCo.jpg", backDropPath: "/pWsRU3EHLpGGiVx2xKUMu6r5haq.jpg")
    static var historyMovie4 = Movie(id: 1504, posterPath: "/xcFulWM3KPT8RRjgEsCWYHG9nxr.jpg", backDropPath: "/amiCH0omIGiuQ0Zz0qfLKGKnSJ0.jpg")
    static var historyMovies: [Movie] {
        return [historyMovie1, historyMovie2, historyMovie3, historyMovie4]
    }
    
    // 음악 영화
    static var musicMovie1 = Movie(id: 1601, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var musicMovie2 = Movie(id: 1602, posterPath: "/exNtEY8QUuQh9e23wBQYeCFpXiU.jpg", backDropPath: "/mDeUmPe4MF35WWlAqj4QFX5UDeO.jpg")
    static var musicMovie3 = Movie(id: 1603, posterPath: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg", backDropPath: "/eSVu1FvGPy86TDo4hQbpuHx55DJ.jpg")
    static var musicMovie4 = Movie(id: 1604, posterPath: "/w4c0GTpmEQ1CZQNHndTv2t7AMzj.jpg", backDropPath: "/xi7kBe6ZgbHfiRs2rYbqraa1nJV.jpg")
    static var musicMovies: [Movie] {
        return [musicMovie1, musicMovie2, musicMovie3, musicMovie4]
    }
    
    // 미스터리 영화
    static var mysteryMovie1 = Movie(id: 1701, posterPath: "/4KV8GTqiKIU04XzAGQl7cEyIHEQ.jpg", backDropPath: "/jZIYaISP3GBSrVOPfrp98AMa8Ng.jpg")
    static var mysteryMovie2 = Movie(id: 1702, posterPath: "/h0ZzIaUGwuAnwDvuVGXhVKYdXQi.jpg", backDropPath: "/sD8YFq4J8lujQrGSkQFBQpbjeQX.jpg")
    static var mysteryMovie3 = Movie(id: 1703, posterPath: "/feSiIcs8zWqiuPHXJkxZykmhSvo.jpg", backDropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg")
    static var mysteryMovie4 = Movie(id: 1704, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var mysteryMovies: [Movie] {
        return [mysteryMovie1, mysteryMovie2, mysteryMovie3, mysteryMovie4]
    }
    
    // TV 영화
    static var tvMovie1 = Movie(id: 1801, posterPath: "/qhb1qOilapbapxWQn9jtRCL7hCo.jpg", backDropPath: "/pWsRU3EHLpGGiVx2xKUMu6r5haq.jpg")
    static var tvMovie2 = Movie(id: 1802, posterPath: "/xcFulWM3KPT8RRjgEsCWYHG9nxr.jpg", backDropPath: "/amiCH0omIGiuQ0Zz0qfLKGKnSJ0.jpg")
    static var tvMovie3 = Movie(id: 1803, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var tvMovie4 = Movie(id: 1804, posterPath: "/exNtEY8QUuQh9e23wBQYeCFpXiU.jpg", backDropPath: "/mDeUmPe4MF35WWlAqj4QFX5UDeO.jpg")
    static var tvMovies: [Movie] {
        return [tvMovie1, tvMovie2, tvMovie3, tvMovie4]
    }
    
    // 전쟁 영화
    static var warMovie1 = Movie(id: 1901, posterPath: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg", backDropPath: "/eSVu1FvGPy86TDo4hQbpuHx55DJ.jpg")
    static var warMovie2 = Movie(id: 1902, posterPath: "/w4c0GTpmEQ1CZQNHndTv2t7AMzj.jpg", backDropPath: "/xi7kBe6ZgbHfiRs2rYbqraa1nJV.jpg")
    static var warMovie3 = Movie(id: 1903, posterPath: "/4KV8GTqiKIU04XzAGQl7cEyIHEQ.jpg", backDropPath: "/jZIYaISP3GBSrVOPfrp98AMa8Ng.jpg")
    static var warMovie4 = Movie(id: 1904, posterPath: "/h0ZzIaUGwuAnwDvuVGXhVKYdXQi.jpg", backDropPath: "/sD8YFq4J8lujQrGSkQFBQpbjeQX.jpg")
    static var warMovies: [Movie] {
        return [warMovie1, warMovie2, warMovie3, warMovie4]
    }
    
    // 서부 영화
    static var westernMovie1 = Movie(id: 2001, posterPath: "/feSiIcs8zWqiuPHXJkxZykmhSvo.jpg", backDropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg")
    static var westernMovie2 = Movie(id: 2002, posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg", backDropPath: "/2R8vKiqH34AG5bpr5J7orONPqgP.jpg")
    static var westernMovie3 = Movie(id: 2003, posterPath: "/qhb1qOilapbapxWQn9jtRCL7hCo.jpg", backDropPath: "/pWsRU3EHLpGGiVx2xKUMu6r5haq.jpg")
    static var westernMovie4 = Movie(id: 2004, posterPath: "/xcFulWM3KPT8RRjgEsCWYHG9nxr.jpg", backDropPath: "/amiCH0omIGiuQ0Zz0qfLKGKnSJ0.jpg")
    static var westernMovies: [Movie] {
        return [westernMovie1, westernMovie2, westernMovie3, westernMovie4]
    }
    
    // 모든 장르의 영화
    static var genreMovies: [String: [Movie]] {
        return [
            "액션": actionMovies,
            "모험": adventureMovies,
            "코미디": comedyMovies,
            "드라마": dramaMovies,
            "SF": sciFiMovies,
            "판타지": fantasyMovies,
            "공포": horrorMovies,
            "로맨스": romanceMovies,
            "스릴러": thrillerMovies,
            "애니메이션": animationMovies,
            "범죄": crimeMovies,
            "다큐멘터리": documentaryMovies,
            "가족": familyMovies,
            "역사": historyMovies,
            "음악": musicMovies,
            "미스터리": mysteryMovies,
            "TV 영화": tvMovies,
            "전쟁": warMovies,
            "서부": westernMovies
        ]
    }
}
