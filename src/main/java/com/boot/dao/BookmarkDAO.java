package com.boot.dao;

import org.apache.ibatis.annotations.Param;

public interface BookmarkDAO {
	int insertBookmark(@Param("userId") String userId, @Param("shopId") int shopId);
    int deleteBookmark(@Param("userId") String userId, @Param("shopId") int shopId);
    boolean isBookmarked(@Param("userId") String userId, @Param("shopId") int shopId);
}
