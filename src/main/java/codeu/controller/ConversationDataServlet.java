package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ConversationDataServlet extends BaseServlet {
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    Map<String, String> messagesInConversation = new HashMap<String, String>();
    String conversationTitle = request.getParameter("chat_name");

    Conversation conversation = conversationStore.getConversationWithTitle(conversationTitle);

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (conversation == null) {
      // Couldn't find conversation, return empty JSON
      System.out.println("Conversation was null: " + conversationTitle);
      String json = new Gson().toJson(messagesInConversation);
      response.getWriter().write(json);
      return;
    }

    UUID conversationId = conversation.getId();

    List<Message> messages = messageStore.getMessagesInConversation(conversationId);
    List<Map> conversationContent = new ArrayList<>();
    for (Message message: messages) {
      Map<String, String> messageContent = new HashMap<String, String>();
      messageContent.put("user", this.userStore.getInstance().getUser(message.getAuthorId()).getName());
      messageContent.put("content", message.getContent());
      conversationContent.add(messageContent);
    }
    String json = new Gson().toJson(conversationContent);
    response.getWriter().write(json);
  }
}
