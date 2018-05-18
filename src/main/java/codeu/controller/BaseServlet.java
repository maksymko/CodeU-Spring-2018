package codeu.controller;

import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import codeu.model.store.basic.MomentStore;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;


/** Base servlet class for servlets that require access to ConversationStore, MessageStore and UserStore. */
public class BaseServlet extends HttpServlet {

  /**
   * Store class that gives access to Conversations.
   */
  protected ConversationStore conversationStore;

  /**
   * Store class that gives access to Messages.
   */
  protected MessageStore messageStore;

  /**
   * Store class that gives access to Users.
   */
  protected UserStore userStore;

  /**
   * Store class that gives access to Moments.
   */
  protected MomentStore momentStore;

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
   * Sets the MomentStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setMomentStore(MomentStore momentStore) {
    this.momentStore = momentStore;
  }

  /**
   * Set up state for handling requests.
   */
  @Override
  public void init() throws ServletException {
    super.init();
    setConversationStore(ConversationStore.getInstance());
    setMessageStore(MessageStore.getInstance());
    setUserStore(UserStore.getInstance());
    setMomentStore(MomentStore.getInstance());
  }
}