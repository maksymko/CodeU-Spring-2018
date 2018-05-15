package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.data.Moment;
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

/** Servlet class responsible for the profileEdit page. */
public class ProfileEditServlet extends BaseServlet {

  /**
   * This function fires when a user navigates to the profileEdit page.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
          throws IOException, ServletException {
    String username = (String) request.getSession().getAttribute("user");

    if (username == null) {
      // user is not logged in, don't let see other users
      response.sendRedirect("/login");
      return;
    }

    User user = userStore.getUser(username);
    if (user == null) {
      // user is not found
      response.sendRedirect("/login");
      return;
    }
    request.setAttribute("user", user);
    request.getRequestDispatcher("/WEB-INF/view/profileEdit.jsp").forward(request, response);
  }

  /**
   * This function fires when a user submit the form on the profileEdit page. It gets the logged-in
   * username from the session and the about me message or moment from the
   * submitted form data.
   */
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
          throws IOException, ServletException {
    String userValue = request.getParameter("message");
    String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
      // user is not logged in, don't let see other users
      response.sendRedirect("/login");
      return;
    }

    User user = userStore.getUser(username);
    if (user == null) {
      // user is not found
      response.sendRedirect("/login");
      return;
    }
    if (request.getParameter("submit_about") != null){
      user.setAbout(userValue);
    } else {
      String momentContent = request.getParameter("moment");

      // this removes any HTML from the message content
      //String cleanedMessageContent = Jsoup.clean(messageContent, Whitelist.none());

      Moment moment =
              new Moment(
                      UUID.randomUUID(),
                      user.getId(),
                      momentContent,
                      Instant.now(),
                      request.getParameter("location"));

      momentStore.addMoment(moment);
    }
    response.sendRedirect("/profile/"+ user.getName());

  }
}
