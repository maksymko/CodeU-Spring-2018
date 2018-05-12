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
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%
Conversation conversation = (Conversation) request.getAttribute("conversation");
List<Message> messages = (List<Message>) request.getAttribute("messages");
%>

<!DOCTYPE html>
<html>
<head>
  <title><%= conversation.getTitle() %></title>
  <%@ include file = "partials/CSS.jsp" %>
  <link rel="stylesheet" href="/css/main.css" type="text/css">

  <script>
    // scroll the chat div to the bottom
    function beginChat() {
      scrollChat();
      pollChatData();
    }
    function scrollChat() {
      var chatDiv = document.getElementById('chat');
      chatDiv.scrollTop = chatDiv.scrollHeight;
    };

    function pollChatData() {
      setTimeout(function() {
        $.ajax({
            type: "GET",
            data: { "chat_name": "<%= conversation.getTitle() %>" },
            url: "/conversation_data", success: function(data) {

            $("#chat ul").empty();
            data.forEach(function (item, index) {
              const profileLink = '<a href="/profile/' + item.user + '">' + item.user + "</a>";
              var message = "<li><strong>" + profileLink + "</strong>: " + item.content + "</li>";
              $("#chat ul").append(message);
            })

            //Setup the next poll recursively
            pollChatData();
          }, dataType: "json"});
      }(), 5000);
    };
  </script>
</head>


<body onload="beginChat()">

  <%@ include file = "partials/navbar.jsp" %>

  <div id="container">

    <h1><%= conversation.getTitle() %>
      <a href="" style="float: right">&#8635;</a></h1>

    <hr/>

    <div id="chat">
      <ul></ul>
    </div>

    <hr/>

    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <input type="text" name="message">
        <br/>
        <button type="submit">Send</button>
    </form>
    <% } else { %>
      <p><a href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>

<%@ include file = "partials/footer.jsp" %>
