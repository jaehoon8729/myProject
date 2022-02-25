package egovframework.example.board.vo;

import java.util.Date;

public class comVo {
	private int board_id;
	private int comment_id;
	private String com_content;
	private String user_id;
	private Date reg_dtm;
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public String getCom_content() {
		return com_content;
	}
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getReg_dtm() {
		return reg_dtm;
	}
	public void setReg_dtm(Date reg_dtm) {
		this.reg_dtm = reg_dtm;
	}
}
