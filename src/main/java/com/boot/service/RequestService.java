// CarRepairRequestService.java
package com.boot.service;

import java.util.List;
import com.boot.dto.RequestDTO;

public interface RequestService {
	void submitRequest(RequestDTO dto);
	List<RequestDTO> getPendingRequests();
	void changeStatus(int id, String status);
	RequestDTO getRequestById(int id);
}
