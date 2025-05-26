package com.boot.dao;

import org.apache.ibatis.annotations.Param;

public interface BookmarkDAO {
	int insertBookmark(
			@Param("userId") String userId,
			@Param("shopId") int shopId,
			@Param("shopType") String shopType);
    int deleteBookmark(
    		@Param("userId") String userId,
    		@Param("shopId") int shopId,
    		@Param("shopType") String shopType);
    boolean isBookmarked(
    		@Param("userId") String userId,
    		@Param("shopId") int shopId,
    		@Param("shopType") String shopType);
}
