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

//@ServerEndpoint("/{room}")
@ServerEndpoint("/websocket")
public class WebSocket {
	//동기화된 set? Map으로 변환
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

	//메세지를 받으면 실행
	@OnMessage
	public void onMessage(String message, Session session) throws IOException{
		System.out.println("메시지 전송: " + session.getId() + ": " + message);
		synchronized (clients) {
			for(Session client : clients) {  
				if(!client.equals(session)) {
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}
	
	//클라이언트 접속 시 실행
	@OnOpen
	public void onOpen(Session session) throws IOException {
		clients.add(session); //세션 추가
		System.out.println("웹소켓 연결: " + session.getId());
		System.out.println(clients.size() + "명");
		
	}
	//접속이 끊겼을 때 처리
	@OnClose
	public void onClose(Session session) throws IOException {
		clients.remove(session);
		System.out.println("웹소켓 종료: " + session.getId());
		
	}
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
	}
}