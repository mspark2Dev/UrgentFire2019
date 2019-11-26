package poly.persistance.mapper;

import config.Mapper;
import poly.dto.NlpDTO;

import java.util.List;

@Mapper("NlpMapper")
public interface NlpMapper {

    List<NlpDTO> getWord(NlpDTO pDTO) throws Exception;

    String getBoardContent(String seq) throws Exception;
}
