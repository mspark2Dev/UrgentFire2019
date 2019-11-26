package poly.service.impl;

import org.springframework.stereotype.Service;
import poly.dto.UserDTO;
import poly.persistance.mapper.UserMapper;
import poly.service.IUserService;

import javax.annotation.Resource;

@Service("UserService")
public class UserService implements IUserService {
	
	@Resource(name="UserMapper")
	private UserMapper userMapper;
	
	@Override
	public int userRegProc(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.userRegProc(uDTO);
	}

	@Override
	public UserDTO getuserinfo(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.userLogin(uDTO);
	}

	@Override
	public int idcheck(String userid) throws Exception {
		return userMapper.idcheck(userid);
	}


	@Override
	public int checkPw(UserDTO uDTO) throws Exception {
		return userMapper.checkPw(uDTO);
	}

	@Override
	public int updatePw(UserDTO uDTO) throws Exception {
		return userMapper.updatePw(uDTO);
	}

	@Override
	public int updateEmail(UserDTO uDTO) throws Exception {
		return userMapper.updateEmail(uDTO);
	}

	@Override
	public String getUserId(String userEmail) throws Exception {
		return userMapper.getUserId(userEmail);
	}

	@Override
	public int resetPassword(UserDTO uDTO) throws Exception {
		return userMapper.resetPassword(uDTO);
	}
}
