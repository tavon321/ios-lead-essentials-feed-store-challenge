//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Gustavo on 31/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {
	
	struct Cache {
		let feed: [LocalFeedImage]
		let timestamp: Date
	}
	
	private var cache: Cache?
	
	public init() { }
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		cache = nil
		completion(nil)
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		self.cache = Cache(feed: feed, timestamp: timestamp)
		completion(nil)
	}
	
	public func retrieve(completion: @escaping RetrievalCompletion) {
		guard let cache = cache else {
			completion(.empty)
			return
		}
		completion(.found(feed: cache.feed, timestamp: cache.timestamp))
	}
	
}
