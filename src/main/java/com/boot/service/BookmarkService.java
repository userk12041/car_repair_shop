package com.boot.service;

public interface BookmarkService {

	boolean toggleBookmark(String userId, int shopId, String shopType);
    boolean isBookmarked(String userId, int shopId, String shopType);
}
