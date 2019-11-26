package poly.persistance.mapper;

import config.Mapper;
import poly.dto.UserDTO;

import java.util.HashMap;
import java.util.List;

@Mapper("AdminMapper")
public interface AdminMapper {
    List<UserDTO> getUserList() throws Exception;

    String getUserCount() throws Exception;

    int updateGroup(HashMap gMap) throws Exception;
}
