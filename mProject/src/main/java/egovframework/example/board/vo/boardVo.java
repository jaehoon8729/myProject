package egovframework.example.board.vo;

import java.util.Date;

public class boardVo {
	private int board_id;
	private String user_id;
	private String title;
	private String content;
	private String file_name;
	private Date reg_dtm;
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public Date getReg_dtm() {
		return reg_dtm;
	}
	public void setReg_dtm(Date reg_dtm) {
		this.reg_dtm = reg_dtm;
	}
}
