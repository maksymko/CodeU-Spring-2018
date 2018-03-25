package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

/** Servlet class responsible for the profile page. */
public class ProfileServlet extends HttpServlet {

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

  /**
   * This function fires when a user navigates to the profile page. It gets the conversation title from
   * the URL, finds the corresponding Conversation, to show a list of all of the conversations a user has participated in
   * It then forwards to profile.jsp for rendering.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
          throws IOException, ServletException {
    String requestUrl = request.getRequestURI();
    String username = requestUrl.substring("/profile/".length());

    User user = userStore.getUser(username);
    if (user == null) {
      // user is not found
      request.setAttribute("error", "Sorry, user "+username+" not found.");
      request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
      return;
    }

    request.setAttribute("view_user", user);
    request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
  }

  /**
   * This function fires when a user submit the form on the profile page. It gets the logged-in
   * username from the session, the conversation title from the URL, and the chat message from the
   * submitted form data.
   */
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
          throws IOException, ServletException {
  }
}
