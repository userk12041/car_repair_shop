// CarRepairRequestServiceImpl.java
package com.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.RequestDAO;
import com.boot.dto.RequestDTO;

@Service
public class RequestServiceImpl implements RequestService {

	@Autowired
	private RequestDAO requestDAO;

	@Override
	public void submitRequest(RequestDTO dto) {
		dto.setStatus("PENDING");
		requestDAO.insertRequest(dto);
	}

	@Override
	public List<RequestDTO> getPendingRequests() {
		return requestDAO.findAllPending();
	}

	@Override
	public void changeStatus(int id, String status) {
		requestDAO.updateStatus(id, status);
	}
	
	@Override
	public RequestDTO getRequestById(int id) {
		return requestDAO.findById(id);
	}
}
