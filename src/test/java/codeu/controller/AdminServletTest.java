package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

public class AdminServletTest {

  private AdminServlet adminservlet;
  private HttpServletRequest mockRequest;
  private HttpSession mockSession;
  private HttpServletResponse mockResponse;
  private RequestDispatcher mockRequestDispatcher;
  private ConversationStore mockConversationStore;
  private MessageStore mockMessageStore;
  private UserStore mockUserStore;

  @Before
  public void setup() {
    adminservlet = new AdminServlet();

    mockRequest = Mockito.mock(HttpServletRequest.class);
    mockSession = Mockito.mock(HttpSession.class);
    Mockito.when(mockRequest.getSession()).thenReturn(mockSession);

    mockResponse = Mockito.mock(HttpServletResponse.class);
    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/admin.jsp"))
        .thenReturn(mockRequestDispatcher);

    mockConversationStore = Mockito.mock(ConversationStore.class);
    adminservlet.setConversationStore(mockConversationStore);

    mockMessageStore = Mockito.mock(MessageStore.class);
    adminservlet.setMessageStore(mockMessageStore);

    mockUserStore = Mockito.mock(UserStore.class);
    adminservlet.setUserStore(mockUserStore);

    mockRequest = Mockito.mock(HttpServletRequest.class);
    mockResponse = Mockito.mock(HttpServletResponse.class);
    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/admin.jsp"))
        .thenReturn(mockRequestDispatcher);
  }

  // @Test
  public void testDoGet() throws IOException, ServletException {
    UUID mostActiveUserUUID = UUID.randomUUID();
    UUID fakeConversationId = UUID.randomUUID();

    Conversation fakeConversation =
          new Conversation(fakeConversationId, mostActiveUserUUID, "test_conversation", Instant.now());
    List<Conversation> fakeConversations = new ArrayList<>();
    fakeConversations.add(fakeConversation);
    Mockito.when(mockConversationStore.getConversations())
          .thenReturn(fakeConversations);
    Mockito.when(mockConversationStore.getNumConvos())
      .thenReturn(1);

    List<Message> fakeMessageList = new ArrayList<>();
    fakeMessageList.add(
        new Message(
            UUID.randomUUID(),
            fakeConversationId,
            mostActiveUserUUID,
            "test message",
            Instant.now()));
    Mockito.when(mockMessageStore.getMessages())
      .thenReturn(fakeMessageList);
    Mockito.when(mockMessageStore.getNumMessages())
      .thenReturn(1);

    List<User> fakeUserList = new ArrayList<>();
    User mostActiveUser = new User(mostActiveUserUUID, "James", "test_password", Instant.now());
    User newestUser = new User(UUID.randomUUID(), "Jon", "test_password", Instant.now());
    fakeUserList.add(mostActiveUser);
    fakeUserList.add(newestUser);
    Mockito.when(mockUserStore.getUsers())
      .thenReturn(fakeUserList);
    Mockito.when(mockUserStore.getUser(mostActiveUserUUID))
      .thenReturn(mostActiveUser);
    Mockito.when(mockUserStore.getNumUsers())
    .thenReturn(2);

    adminservlet.doGet(mockRequest, mockResponse);

    Mockito.verify(mockRequest).setAttribute("numUsers", 2);
    Mockito.verify(mockRequest).setAttribute("numConvos", 1);
    Mockito.verify(mockRequest).setAttribute("numMessages", 1);
    Mockito.verify(mockRequest).setAttribute("mostActiveUser", "James");
    Mockito.verify(mockRequest).setAttribute("newestUser", "Jon");
    Mockito.verify(mockRequest).setAttribute("wordiestUser", "James");
    Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
  }
}
