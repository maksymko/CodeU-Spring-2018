<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.Instant" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>

<% User user = (User) request.getAttribute("view_user"); %>
<% String about = (String) request.getAttribute("aboutme"); %>
<!DOCTYPE html>
<html>
<head>
    <title>
        <% if(request.getAttribute("error") != null) { %>
        User Not Found.
        <% } else { %>
        <%= user.getName() %>'s Profile Page
        <% } %>
    </title>
    <%@ include file = "partials/CSS.jsp" %>

    <script>
        // scroll the chat div to the bottom
        function scrollChat() {
            var chatDiv = document.getElementById('chat');
            chatDiv.scrollTop = chatDiv.scrollHeight;
        };
    </script>
</head>
<body onload="scrollChat()">

 <%@ include file = "partials/navbar.jsp" %>

 <div id="container">
    <% if(request.getAttribute("error") != null){ %>
    <h2 class="error"><%= request.getAttribute("error") %></h2>
    <% } else { %>

    <h1 style= "text-align: center;"><%= user.getName() %>'s Profile Page</h1>
    <hr/>
    <h2 style= "text-align: center;"> About <%= user.getName() %>
    <% if( user.getName().equals(request.getSession().getAttribute("user")) ) { %>
      <h3 style= "text-align: center;"> Edit your About Me (only you can see this) </h3>
       <form action="/profile/" style= "text-align: center;" method="POST">
          <input type="text" name="message" value="<%= about %>">
          <br>
          <input type="submit" value="Submit">
        </form>
    <% } else { %>
      <p style="color: red"><%= about %></p>
    <% } %>
    </h2>
    <hr/>
    <h2 style= "text-align: center;"><%= user.getName() %>'s Sent Messages</h2>

    <div id="chat">
        <ul>
            <%
                List<Message> messages = (List<Message>) request.getAttribute("messages");
                for (Message message : messages) {
                    Instant time = message.getCreationTime();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE yyyy-MM-dd HH:mm:ss")
                            .withZone(ZoneId.systemDefault());

                    String timeString = formatter.format(time);
            %>
            <li><strong><%= timeString %>:</strong> <%= message.getContent() %></li>
            <%
                }
            %>
        </ul>
    </div>
    <hr/>
    <% } %>
 </div>
<%@ include file = "partials/footer.jsp" %>