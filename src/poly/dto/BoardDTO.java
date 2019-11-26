package poly.dto;

public class BoardDTO {
    private String title;
    private String content;
    private String regId;
    private String updDate;
    private String seq;
    private String maxseq;
    private String notice_yn;

    public String getNotice_yn() {
        return notice_yn;
    }

    public void setNotice_yn(String notice_yn) {
        this.notice_yn = notice_yn;
    }

    public String getMaxseq() {
        return maxseq;
    }

    public void setMaxseq(String maxseq) {
        this.maxseq = maxseq;
    }

    public String getUpdDate() {
        return updDate;
    }

    public void setUpdDate(String updDate) {
        this.updDate = updDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }
}
