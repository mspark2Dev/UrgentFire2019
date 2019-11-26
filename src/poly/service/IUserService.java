package poly.service;

		import poly.dto.UserDTO;

public interface IUserService {

	int userRegProc(UserDTO uDTO) throws Exception;

	UserDTO getuserinfo(UserDTO uDTO) throws Exception;

	int idcheck(String userid) throws Exception;

	int checkPw(UserDTO uDTO) throws Exception;

    int updatePw(UserDTO uDTO) throws Exception;

	int updateEmail(UserDTO uDTO) throws Exception;

    String getUserId(String userEmail) throws Exception;

	int resetPassword(UserDTO uDTO)throws Exception;
}