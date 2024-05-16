package rank;

import lombok.Data;

@Data
public class RankVO {
	private String userId;
	private String nickname;
	private int win;
	private int lose;
	private int idx;

}