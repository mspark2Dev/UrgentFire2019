package poly.persistance.mapper;

import config.Mapper;
import poly.dto.BoardDTO;

import java.util.HashMap;
import java.util.List;

@Mapper("BoardMapper")
public interface BoardMapper {
    List<BoardDTO> getBoardList(HashMap hMap)throws Exception;

    int insertBoardInfo(BoardDTO bDTO)throws Exception;

    BoardDTO getBoardDetail(String seq)throws Exception;

    String getMaxseq()throws Exception;

    int setNotice(String seq)throws Exception;

    int setNoticeN(String seq)throws Exception;

    int deleteBoardProc(String seq)throws Exception;

    int UpdateBoardInfo(BoardDTO bDTO)throws Exception;

    List<BoardDTO> getMyBoardList(HashMap<String, Object> hMap) throws Exception;

    int getMyMaxSeq(String userId)throws Exception;
}
