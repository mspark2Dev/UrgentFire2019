package poly.persistance.mapper;

import config.Mapper;
import poly.dto.UserDTO;

@Mapper("UserMapper")
public interface UserMapper {

	int userRegProc(UserDTO uDTO) throws Exception;

	UserDTO userLogin(UserDTO uDTO) throws Exception;

	int idcheck(String userid) throws Exception;

	int checkPw(UserDTO uDTO) throws Exception;

	int updatePw(UserDTO uDTO) throws Exception;

	int updateEmail(UserDTO uDTO) throws Exception;

    String getUserId(String userEmail)throws Exception;

	int resetPassword(UserDTO uDTO)throws Exception;
}
