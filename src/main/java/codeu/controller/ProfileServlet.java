package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

/** Servlet class responsible for the profile page. */
public class ProfileServlet extends BaseServlet {

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
    String about = user.getAbout();
    List<Message> authorMessages = messageStore.getMessagesByUser(user.getId());

    request.setAttribute("messages", authorMessages);
    request.setAttribute("aboutme", about);
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
    String userValue = request.getParameter("message");
    String username = (String) request.getSession().getAttribute("user");
    User user = userStore.getUser(username);
      if (username == null) {
        // user is not logged in, don't let see other users
        response.sendRedirect("/login");
        return;
      }
    user.setAbout(userValue);

    response.sendRedirect(user.getName());

  }
}
