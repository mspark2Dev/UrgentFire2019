package poly.service.impl;

import org.springframework.stereotype.Service;
import poly.dto.BoardDTO;
import poly.persistance.mapper.BoardMapper;
import poly.service.IBoardService;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service("BoardService")
public class BoardService implements IBoardService {

    @Resource(name="BoardMapper")
    private BoardMapper boardMapper;

    @Override
    public List<BoardDTO> getBoardList(HashMap hMap) throws Exception {
        return boardMapper.getBoardList(hMap);
    }

    @Override
    public int insertBoardInfo(BoardDTO bDTO) throws Exception {
        return boardMapper.insertBoardInfo(bDTO);
    }

    @Override
    public BoardDTO getBoardDetail(String seq) throws Exception {
        return boardMapper.getBoardDetail(seq);
    }

    @Override
    public String getMaxseq() throws Exception {
        return boardMapper.getMaxseq();
    }

    @Override
    public int getMyMaxseq(String userId) throws Exception {
        return boardMapper.getMyMaxSeq(userId);
    }

    @Override
    public int setNotice(String seq) throws Exception {
        return boardMapper.setNotice(seq);
    }

    @Override
    public int setNoticeN(String seq) throws Exception {
        return boardMapper.setNoticeN(seq);
    }

    @Override
    public int deleteBoardProc(String seq) throws Exception {
        return boardMapper.deleteBoardProc(seq);
    }

    @Override
    public int UpdateBoardInfo(BoardDTO bDTO) throws Exception {
        return boardMapper.UpdateBoardInfo(bDTO);
    }

    @Override
    public List<BoardDTO> getMyBoardList(HashMap<String, Object> hMap) throws Exception {
        return boardMapper.getMyBoardList(hMap);
    }
}
