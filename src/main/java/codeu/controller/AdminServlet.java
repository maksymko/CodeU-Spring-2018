package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import java.util.List;
import java.util.HashMap;
import java.util.UUID;
import java.time.Instant;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet class responsible for user registration.
 */
public class AdminServlet extends HttpServlet {
  /** Store class that gives access to Conversations. */
  private ConversationStore conversationStore;

  /** Store class that gives access to Messages. */
  private MessageStore messageStore;

  /** Store class that gives access to Users. */
  private UserStore userStore;

  /** Set up state for handling chat requests. */
  @Override
  public void init() throws ServletException {
    super.init();
    setConversationStore(ConversationStore.getInstance());
    setMessageStore(MessageStore.getInstance());
    setUserStore(UserStore.getInstance());
  }

  /**
   * Sets the ConversationStore used by this servlet. This function provides a common setup method
   * for use by the test framework or the servlet's init() function.
   */
  void setConversationStore(ConversationStore conversationStore) {
    this.conversationStore = conversationStore;
  }

  /**
   * Sets the MessageStore used by this servlet. This function provides a common setup method for
   * use by the test framework or the servlet's init() function.
   */
  void setMessageStore(MessageStore messageStore) {
    this.messageStore = messageStore;
  }

  /**
   * Sets the UserStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    request.setAttribute("numUsers", numUsers());
    request.setAttribute("numConvos", numConvos());
    request.setAttribute("numMessages", numMessages());
    request.setAttribute("mostActiveUser", mostActiveUser());
    request.setAttribute("newestUser", newestUser());
    request.setAttribute("wordiestUser", wordiestUser());
    request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);
  }

  /** Returns number of users in database */
  private int numUsers() {
    return this.userStore.getUsers().size();
  }

  /** Returns number of conversations in database */
  private int numConvos() {
    return this.conversationStore.getConversations().size();
  }

  /** Returns number of messages in database */
  private int numMessages() {
    return this.messageStore.getMessages().size();
  }

  /** Calculated by user with most messsages sent and most conversations started */
  private String mostActiveUser() {
    // Mapping User's UUID to the frequency of their contributions
    HashMap<UUID, Integer> frequencyMap = new HashMap<UUID, Integer>();
    String mostActiveUserName = "No messages/conversations posted";
    List<Conversation> conversations = this.conversationStore.getConversations();
    List<Message> messages = this.messageStore.getMessages();

    for (Conversation conversation : conversations) {
      UUID conversationOwner = conversation.getOwnerId();
      frequencyMap.merge(conversationOwner, 1, Integer::sum);
    }

    for (Message message : messages) {
      UUID messageOwner = message.getAuthorId();
      frequencyMap.merge(messageOwner, 1, Integer::sum);
    }

    try {
      // Finding UUID with max value (contributions)
      UUID mostActiveUserUUID = frequencyMap.entrySet().stream().max((entry1, entry2) -> entry1.getValue() > entry2.getValue() ? 1 : -1).get().getKey();
      mostActiveUserName = this.userStore.getUser(mostActiveUserUUID).getName();
    } catch (Exception e) {
      System.out.println(e.getMessage());
    }
    return mostActiveUserName;
  }

  /** Returns newest member by creation date */
  private String newestUser() {
    String newestUser = "No users added";
    Instant newestUserCreationTime = Instant.MIN;
    List<User> users = this.userStore.getUsers();

    for (User user : users) {
      if (user.getCreationTime().isAfter(newestUserCreationTime)) {
        newestUserCreationTime = user.getCreationTime();
        newestUser = user.getName();
      }
    }

    return newestUser;
  }

  /** Returns User with max individual words sent */
  private String wordiestUser() {
    // Mapping User's UUID to the frequency of their words sent
    HashMap<UUID, Integer> frequencyMap = new HashMap<UUID, Integer>();
    String wordiestUser = "No users added";
    List<Message> messages = this.messageStore.getMessages();

    for (Message message: messages) {
      UUID messageOwner = message.getAuthorId();
      int wordsInMessage = message.getContent().split("\\w+").length;
      frequencyMap.merge(messageOwner, wordsInMessage, Integer::sum);
    }

    try {
      // Finding UUID with max value (words sent)
      UUID wordiestUserUUID = frequencyMap.entrySet().stream().max((entry1, entry2) -> entry1.getValue() > entry2.getValue() ? 1 : -1).get().getKey();
      wordiestUser = this.userStore.getUser(wordiestUserUUID).getName();
    } catch (Exception e) {
      System.out.println(e.getMessage());
    }

    return wordiestUser;
  }
}
