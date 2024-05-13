package game;

import java.util.*;

public class Board {
	// 게임 관련 변수들
	private final int SIZE = 15;
	Integer[][] board = new Integer[SIZE][SIZE];
	// 게임 종료 여부
	boolean finish = false;
	String winner;

    // 보드 초기화
    public Board() {
        for (int i = 0; i < SIZE; i++) {
            Arrays.fill(board[i], 0);
        }
    }
    
    public void printBoard() {
    	System.out.println();
    	
    	for (int i = 0; i < SIZE; i++) {
    		for (int j = 0; j < SIZE; j++) {
    			System.out.print(board[i][j]);
    		}
    		System.out.println();
    	}
    	System.out.println();
    }

    public boolean setStone(int x, int y, int currentPlayer) {
        if (x < 0 || x >= SIZE || y < 0 || y >= SIZE || board[y][x] != 0) {
        	System.out.println("보드 판 벗어남 or 이미 돌이 놓아진 위치임");
            return false;
        }
        
        board[y][x] = currentPlayer;
        return true;
    }
    
    // 33룰, 44룰, 장목 금지, 승리 여부 체크
    public String checkRule(int x, int y, int currentPlayer) {
        // 돌의 상하좌우, 대각선 방향으로 체크하는 배열
        String[] check = new String[4];
        System.out.println(x + " " + y);
        // 돌의 주변을 확인하여 체크 배열에 기록
        for (int i = 5; i > 0; i--) {
        	if (y - i > -1 && x - i > -1)
        		check[2] += board[y - i][x - i] + "";	// 대각선 ↖️
        	if (y - i > -1 && x + i < SIZE)
        		check[3] += board[y - i][x + i] + "";	// 대각선 ↗️
        	if (x - i > -1)
        		check[0] += board[y][x - i] + "";		// 가로 ←
        	if (y - i > -1)
        		check[1] += board[y - i][x] + "";		// 세로 ↑
        }
        // 반대 방향을 확인하여 체크 배열에 기록
        for (int i = 0; i < 6; i++) {
        	if (y + i < SIZE && x + i < SIZE)
        		check[2] += board[y + i][x + i] + "";	// 대각선 ↘️
        	if (y + i < SIZE && x - i > -1)
        		check[3] += board[y + i][x - i] + "";	// 대각선 ↙️
        	if (x + i < SIZE)
        		check[0] += board[y][x + i] + "";		// 가로 →
        	if (y + i < SIZE)
        		check[1] += board[y + i][x] + "";		// 세로 ↓
        }
        // 흑돌의 경우 33, 44 룰 적용
        if (currentPlayer == 1) {
        	int count33 = 0, count44 = 0;
        	// 각 방향에 대해서 33룰과 44룰을 확인
        	for (int i = 0; i < check.length; i++) {
        		if (check[i].contains("01110") || check[i].contains("011010") || check[i].contains("010110"))
        			count33++;
        		// 44룰 확인 (연속된 4개의 돌이 있으며, 양 끝이 비어있어야 함)
        		count44 += ((check[i].contains("1111") || check[i].contains("11011") || check[i].contains("10111")
        				|| check[i].contains("11101")) && !check[i].contains("211112") && !check[i].contains("11211")
        				&& !check[i].contains("11121") && !check[i].contains("12111")) ? 1 : 0;
        	}
        	// 33룰이나 44룰이 2번 이상 발견되면 착수 불가능하게 함
        	if (count33 > 1 || count44 > 1) {
        		// 무르기 실행
        		back(x, y);
        	    //System.out.println("착수 할 수 없습니다.");
        		return "badPosition";
        	}
        }
        // 승리 확인
        for (int i = 0; i < check.length; i++) {
        	// 승리 조건 확인 (흑돌의 경우 11111이 나오는 경우만 승리 = 장목 금지)
        	if ((check[i].matches(".*[^1]" + "11111" + "[^1].*") && currentPlayer == 1)
        			|| (check[i].contains("22222") && currentPlayer == 2)) {		// 백돌의 경우 22222가 나오면 승리
        		winner = currentPlayer==1 ? "black" : "white";
        		// 게임 종료
        		finish = true;
        		return winner;
        	}
    	}
        return "goodPostion";
    }
    
    // 무르기 기능 메서드
 	private void back(int x, int y) {
 		// 마지막에 놓은 돌 제거하고 패널 다시 그리기
 		board[y][x] = 0;
 	}

}