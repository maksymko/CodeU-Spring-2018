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
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>

<% User user = (User) request.getAttribute("view_user"); %>
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
    <h1><%= user.getName() %>'s Profile Page</h1>

    <hr/>
    <h2> About <%= user.getName() %>
    </h2>
    <hr/>
    <h2><%= user.getName() %>'s Sent Messages</h2>

    <hr/>
    <div id="chat">

    </div>
    <hr/>
    <% } %>
</div>

</body>
</html>
