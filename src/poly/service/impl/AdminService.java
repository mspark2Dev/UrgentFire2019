package poly.service.impl;

import org.springframework.stereotype.Service;
import poly.dto.UserDTO;
import poly.persistance.mapper.AdminMapper;
import poly.service.IAdminService;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service("AdminService")
public class AdminService implements IAdminService {

    @Resource(name = "AdminMapper")
    private AdminMapper adminMapper;

    @Override
    public List<UserDTO> getUserList() throws Exception {
        return adminMapper.getUserList();
    }

    @Override
    public String getUserCount() throws Exception {
        return adminMapper.getUserCount();
    }

    @Override
    public int updateGroup(HashMap gMap) throws Exception {
        return adminMapper.updateGroup(gMap);
    }
}
