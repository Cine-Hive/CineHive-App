//
//  SupabaseManager.swift
//  CineHive
//
//  Created by 존진 on 10/15/25.
//

import Foundation
import Supabase

final class SupabaseManager {
    static let shared = SupabaseManager()
    private init() {}
    
    let client = SupabaseConfig.shared.client
    var auth: AuthClient { client.auth }

    // MARK: - PostgREST

    /// SELECT
    @discardableResult
    func selectRaw(
        _ table: String,
        columns: String = "*",
        filter: ((PostgrestFilterBuilder) -> PostgrestFilterBuilder)? = nil
    ) async throws -> Data {
        let base = client.from(table).select(columns)
        let fb = filter?(base) ?? base
        let res = try await fb.execute()
        return res.data
    }

    /// INSERT
    @discardableResult
    func insertRaw(
        _ table: String,
        values: [[String: AnyJSON]],
        returning: PostgrestReturningOptions = .representation
    ) async throws -> Data {
        let res = try await client
            .from(table)
            .insert(values, returning: returning)
            .execute()
        return res.data
    }

    /// UPDATE
    @discardableResult
    func updateRaw(
        _ table: String,
        values: [String: AnyJSON],
        filter: (PostgrestFilterBuilder) -> PostgrestFilterBuilder,
        returning: PostgrestReturningOptions = .representation
    ) async throws -> Data {
        let qb = try client.from(table).update(values, returning: returning)
        let res = try await filter(qb).execute()
        return res.data
    }

    /// DELETE
    @discardableResult
    func deleteRaw(
        _ table: String,
        filter: (PostgrestFilterBuilder) -> PostgrestFilterBuilder,
        returning: PostgrestReturningOptions = .minimal
    ) async throws -> Data {
        let qb = client.from(table).delete(returning: returning)
        let res = try await filter(qb).execute()
        return res.data
    }

    /// RPC
    @discardableResult
    func callRPC(
        _ fn: String,
        params: [String: AnyJSON] = [:]
    ) async throws -> Data {
        let res = try await client.rpc(fn, params: params).execute()
        return res.data
    }
    
    func callRPCBool(_ fn: String, params: [String: AnyJSON] = [:]) async throws -> Bool {
        let data = try await callRPC(fn, params: params)
        return (try? decode(data, as: Bool.self)) ?? false
    }

    // MARK: - Decoding

    func decode<T: Decodable>(_ data: Data, as: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: data)
    }

    func decodeArray<T: Decodable>(_ data: Data, as: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> [T] {
        try decoder.decode([T].self, from: data)
    }
}
