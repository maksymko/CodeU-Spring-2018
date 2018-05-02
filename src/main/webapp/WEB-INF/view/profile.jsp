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
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Custome CSS -->
    <link rel="stylesheet" href="/css/main.css" type="text/css">

    <script>
        // scroll the chat div to the bottom
        function scrollChat() {
            var chatDiv = document.getElementById('chat');
            chatDiv.scrollTop = chatDiv.scrollHeight;
        };
    </script>
</head>
<body onload="scrollChat()">

<nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if (request.getSession().getAttribute("user") != null) { %>
    <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <a href="/profile/<%= request.getSession().getAttribute("user") %>"><%= request.getSession().getAttribute("user") %> Profile Page</a>
    <a href="/login">Logout</a>
    <% } else { %>
    <a href="/login">Login</a>
    <a href="/register">Register</a>
    <% } %>
    <a href="/about.jsp">About</a>
</nav>

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
  <!-- jQuery -->
  <script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  <!-- Latest compiled and minified bootstrap JavaScript -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>
