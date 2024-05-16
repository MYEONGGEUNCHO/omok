package game;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONObject;

@ServerEndpoint("/server")
public class Server {

	// 연결된 clients 저장
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

	// 서버 접속되었을 때 board 객체 1번 생성
	private static Board board = new Board();

	@OnOpen
	public void onOpen(Session session) throws IOException {
		if (clients.size() < 2) {
			
			clients.add(session);
			System.out.println("Client connected: " + session.getId());
			System.out.println("client size : " + clients.size());
			
		} else {
			System.out.println("---------------");
			System.out.println("Maximum clients reached. Cannot accept new connections.");
		}
	}
	
	// client 에게 받은 메세지 처리 (type 구분)
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("Received from client " + session.getId() + ": " + message);

		JSONObject jsonMessage = new JSONObject(message);
		String type = jsonMessage.getString("type");
		System.out.println("server type : " + type);
		switch (type) {
		case "chat":
			handleChatMessage(jsonMessage, session);
			break;
		case "gomok":
			handleOmokMessage(jsonMessage, session);
			break;
		case "sessionInfo":
			handleSessionInfo(jsonMessage, session);
			break;
		default:
			System.out.println("Unknown message type: " + type);
		}
	}

	private void handleOmokMessage(JSONObject jsonMessage, Session session) throws IOException {
		int x = (int) jsonMessage.get("x");
		int y = (int) jsonMessage.get("y");
		int currentPlayer = (int) jsonMessage.get("currentPlayer");
		String type = jsonMessage.getString("type");
		System.out.println("Received move data - X: " + x + ", Y: " + y + ", Stone: " + currentPlayer);

		// Board 객체 사용해서 룰 체크 -> 상태(돌 놓는 규칙 위배 여부, 승패 확인) 종류 별로 다르게 클라이언트로 전달
		// 1. 돌 놓는 위치가 아닌 경우(badPosition) : 사용자에게 알림
		// 2. 돌 놓는 위치가 맞는 경우(goodPosition) : 오목 그려줌
		// 3. 승/패가 결정된 경우(black/white) : 사용자에게 알림

		// 내 turn의 내 돌 색깔만 놓을 수 있음
		String state = "badPosition";
		boolean myTurn = Integer.parseInt(session.getId()) + 1 == currentPlayer;
		if (myTurn) {
			if (!board.setStone(x, y, currentPlayer)) {
				state = "badPosition";
			} else {
				state = board.checkRule(x, y, currentPlayer);
			}
		}

		board.printBoard();
		// x, y, currentPlayer, state
		JSONObject returnObject = new JSONObject();
		returnObject.put("type", type);
		returnObject.put("x", x);
		returnObject.put("y", y);
		returnObject.put("currentPlayer", currentPlayer);
		returnObject.put("state", state);
		returnObject.put("myTurn", myTurn);
		String jsonInfo = returnObject.toString();

		for (Session client : clients) {
			client.getBasicRemote().sendText(jsonInfo);
		}
	}

	//채팅 메세지일 경우
	private void handleChatMessage(JSONObject jsonMessage, Session session) throws IOException {
		String type = jsonMessage.getString("type");
		String message = jsonMessage.getString("chatMessage");
		System.out.println("메시지 전송: " + session.getId() + ": " + message);
		JSONObject returnObject = new JSONObject();
		returnObject.put("type", type);
		returnObject.put("message", message);
		String jsonInfo = returnObject.toString();
		synchronized (clients) {
			for (Session client : clients) {
				if (!client.equals(session)) {
					client.getBasicRemote().sendText(jsonInfo);
				}
			}
		}
	}
	
	//내 정보 보내기
	private void handleSessionInfo(JSONObject jsonMessage, Session session) throws IOException {
		String nickname = jsonMessage.getString("nickname");
		String profile = jsonMessage.getString("profile");
		int win = jsonMessage.getInt("win");
		int lose = jsonMessage.getInt("lose");

		JSONObject jsonInfo = new JSONObject();
		jsonInfo.put("type", "sessionInfo");
		jsonInfo.put("profile", profile);
		jsonInfo.put("nickname", nickname);
		jsonInfo.put("win", win);
		jsonInfo.put("lose", lose);
		String message = jsonInfo.toString();

		System.out.println("내 정보 보내기"+message);
		for (Session client : clients) {
			if (!client.equals(session)) {
				client.getBasicRemote().sendText(message);
			}
		}
	}
	

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("Client disconnected: " + session.getId());
	}

	@OnError
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
	}

}