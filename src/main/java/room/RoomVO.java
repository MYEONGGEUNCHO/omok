package room;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RoomVO {
    private int roomId;   // 방 고유 ID
    private String roomName; // 방 이름
    private int time;        // 게임 제한 시간 (분)
    private String user1;    // 방을 생성한 회원 ID
    private String user2;    // 방에 접속한 회원 ID
}
