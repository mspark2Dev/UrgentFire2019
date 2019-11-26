package poly.service;

import poly.dto.UserDTO;

import java.util.HashMap;
import java.util.List;

public interface IAdminService {
    List<UserDTO> getUserList() throws Exception;

    String getUserCount() throws Exception;

    int updateGroup(HashMap gMap) throws Exception;
}
