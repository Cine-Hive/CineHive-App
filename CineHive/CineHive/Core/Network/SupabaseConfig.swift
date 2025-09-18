//
//  SupabaseConfig.swift
//  CineHive
//
//  Created by 존진 on 9/11/25.
//

import Foundation
import Supabase

class SupabaseConfig {
    static let shared = SupabaseConfig()  // 싱글톤 인스턴스

    let client: SupabaseClient

    private init() {
        guard let supabaseURL = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
              let supabaseKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String else {
            fatalError("Supabase credentials not found")
        }

        self.client = SupabaseClient(supabaseURL: URL(string: supabaseURL)!,
                                     supabaseKey: supabaseKey)
    }
}
