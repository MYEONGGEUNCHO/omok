package game;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONObject;

@ServerEndpoint("/server")
public class Server {
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
    private static Board board = new Board();
    @OnOpen
    public void onOpen(Session session) {
    	if (clients.size() < 2) {
            clients.add(session);
            System.out.println("Client connected: " + session.getId());
            System.out.println("client size : " + clients.size());
        } else if(clients.size() == 2) {
        	System.out.println("Client connected: " + session.getId());
        	System.out.println("client size : " + clients.size());
        } else {
        	System.out.println("---------------");
            System.out.println("Maximum clients reached. Cannot accept new connections.");
            System.out.println("Client connected: " + session.getId());
            System.out.println("client size : " + clients.size());
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
    	System.out.println("Received from client " + session.getId() + ": " + message);
    	JSONObject turn = new JSONObject(message);
    	int x = (int) turn.get("x");
    	int y = (int) turn.get("y");
    	int currentPlayer = (int) turn.get("currentPlayer");
    	System.out.println("Received move data - X: " + x + ", Y: " + y + ", Stone: " + currentPlayer);
    	
    	// Board 객체 사용해서 룰 체크 -> 상태(돌 놓는 규칙 위배 여부, 승패 확인) 종류 별로 다르게 클라이언트로 전달
    	// 		1. 돌 놓는 위치가 아닌 경우(badPosition) : 사용자에게 알림
    	// 		2. 돌 놓는 위치가 맞는 경우(goodPosition) : 오목 그려줌
    	//		3. 승/패가 결정된 경우(black/white) : 사용자에게 알림
    	
    	// 내 turn의 내 돌 색깔만 놓을 수 있음
    	String state = "badPosition";
    	boolean myTurn = Integer.parseInt(session.getId()) + 1 == currentPlayer;
    	if(myTurn) {
    		if(!board.setStone(x, y, currentPlayer)) {
    			state = "badPosition";
    		} else {
    			state = board.checkRule(x, y, currentPlayer);
    		}
    	}
    	
    	board.printBoard();
    	// x, y, currentPlayer, state 
    	JSONObject returnObject = new JSONObject();
    	returnObject.put("x", x);
    	returnObject.put("y", y);
    	System.out.println("확인영" + currentPlayer);
    	System.out.println("-----------");
    	returnObject.put("currentPlayer", currentPlayer);
    	returnObject.put("state", state);
    	returnObject.put("myTurn", myTurn);
    	String jsonInfo = returnObject.toString();
    	
    	for (Session client : clients) {
    		//client.getBasicRemote().sendText("Opossite move data - X: " + x + ", Y: " + y + ", Stone: " + currentPlayer);
    		client.getBasicRemote().sendText(jsonInfo);
    	}
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        System.out.println("Client disconnected: " + session.getId());
    }

}