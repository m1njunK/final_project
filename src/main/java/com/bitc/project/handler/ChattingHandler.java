package com.bitc.project.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.Getter;

@Component
@Getter
public class ChattingHandler extends TextWebSocketHandler {

    private List<WebSocketSession> list = new ArrayList<>();
    private List<Map<String, Object>> roomList = new ArrayList<>();
    private int roomNum = 1;

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        String[] code = payload.split(":");

        if (code[0].equals("ENTER")) {
            String roomNum = code[1];
            String userId = code[2];

            session.getAttributes().put("userId", userId);
            session.getAttributes().put("roomNum", roomNum);

            Map<String, Object> room = findMap(roomList, roomNum);
            if (room != null) {
                List<WebSocketSession> participants = (List<WebSocketSession>) room.getOrDefault("participant", new ArrayList<>());
                if (participants.isEmpty()) {
                    session.getAttributes().put("owner", userId);
                    room.put("owner", userId);
                }
                participants.add(session);
                room.put("participant", participants);
                for (WebSocketSession user : participants) {
                    if (user.isOpen()) {
                        user.sendMessage(new TextMessage(userId + "님이 접속하였습니다!"));
                    }
                }
            }
        } else if (code[0].equals("GET_USERS")) {
            Map<String, Object> room = findMap(roomList, code[1]);
            updateUsersInRoom(room);
        } else {
            Map<String, Object> room = findMap(roomList, code[0]);
            String userId = code[1];
            List<WebSocketSession> roomSessions = (List<WebSocketSession>) room.get("participant");
            for (WebSocketSession user : roomSessions) {
                if (user.isOpen()) {
                    user.sendMessage(new TextMessage(userId + ":" + makeMassage(code)));
                }
            }
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        list.add(session);
        
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        list.remove(session);

        String userId = (String) session.getAttributes().get("userId");
        String roomNum = (String) session.getAttributes().get("roomNum");

        Map<String, Object> room = findMap(roomList, roomNum);
        if (room != null) {
            List<WebSocketSession> roomSessions = (List<WebSocketSession>) room.get("participant");
            if (roomSessions.contains(session) && userId.equals(room.get("owner"))) {
                roomSessions.remove(session);
                if (!roomSessions.isEmpty()) {
                    String newOwner = (String) roomSessions.get(0).getAttributes().get("userId");
                    room.put("owner", newOwner);
                    for (WebSocketSession user : roomSessions) {
                        if (user.isOpen()) {
                            user.sendMessage(new TextMessage("방장이 탈주하였습니다!! 새로운 방장은 " + newOwner + "입니다!"));
                        }
                    }
                } else {
                    roomList.remove(room);
                }
            } else {
                roomSessions.remove(session);
                for (WebSocketSession user : roomSessions) {
                    if (user.isOpen()) {
                        user.sendMessage(new TextMessage(userId + "님이 탈주하였습니다!"));
                    }
                }
            }
            updateUsersInRoom(room);
        }
    }

    public Map<String, Object> creatRoom() {
        Map<String, Object> createdRoom = new HashMap<>();
        createdRoom.put("roomNum", roomNum);
        roomList.add(createdRoom);
        roomNum++;
        return createdRoom;
    }

    public Map<String, Object> findMap(List<Map<String, Object>> list, String roomNum) {
        int num = Integer.parseInt(roomNum);
        for (Map<String, Object> map : list) {
            if (map.containsValue(num)) {
                return map;
            }
        }
        return null;
    }

    public String makeMassage(String[] code) {
        StringBuilder message = new StringBuilder();
        for (int i = 2; i < code.length; i++) {
            message.append(code[i]);
        }
        return message.toString();
    }

    private void updateUsersInRoom(Map<String, Object> room) throws IOException {
        List<WebSocketSession> participants = (List<WebSocketSession>) room.get("participant");
        List<String> userList = new ArrayList<>();

        for (WebSocketSession participant : participants) {
            userList.add((String) participant.getAttributes().get("userId"));
        }

        String userListStr = String.join(",", userList);

        for (WebSocketSession participant : participants) {
            if (participant.isOpen()) {
                participant.sendMessage(new TextMessage("USERS:" + userListStr));
            }
        }
    }
}
