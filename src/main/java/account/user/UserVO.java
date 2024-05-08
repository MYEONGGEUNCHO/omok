package account.user;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	private String userId;
	private String pwd;
	private String nickname;
	private String profile;
	private Date createDate;
	private Date updateDate;
	private int win;
	private int lose;
}
