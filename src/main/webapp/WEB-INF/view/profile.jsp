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
<%@ page import="codeu.model.data.Moment" %>

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

    <h1 style= "text-align: center;"><%= user.getName() %>'s Profile Page
     <% if( user.getName().equals(request.getSession().getAttribute("user")) ) { %>
     <form action="/profileEdit" style= "text-align: center;">
         <input type="submit" value="Edit My Profile" >
     </form>
     <% } %>
    </h1>

    <h2 style= "text-align: center;"> About <%= user.getName() %>

    <% if( user.getName().equals(request.getSession().getAttribute("user")) ) { %>
      <p style= "text-align: center;"> Edit your About Me </p>
       <form action="/profile/" style= "text-align: center;" method="POST">
          <input type="text" name="message" value="<%= about %>">
          <br>
          <input type="submit" value="Submit">
        </form>
    <% } else { %>
      <p style="color: red"><%= about %></p>
    <% } %>

      <p style="color: red; text-align: center"><%= about %></p>

    </h2>

     <h2 style= "text-align: center;"><%= user.getName() %>'s Moments</h2>
     <div>
         <ul id="moments">
             <%
                 List<Moment> moments = (List<Moment>) request.getAttribute("moments");
                 for (Moment moment : moments) {
                     Instant time = moment.getCreationTime();
                     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE yyyy-MM-dd HH:mm:ss")
                             .withZone(ZoneId.systemDefault());

                     String timeString = formatter.format(time);
             %>
             <li> <div class="container">
                 <strong><%= moment.getContent() %></strong> <br>
                 <em><%= timeString %></em>
                 <% if(moment.getLocation()!="") %> <em>@<%= moment.getLocation() %></em>
             </div> </li>
             <hr>
             <% } %>
         </ul>
         <% if(moments.isEmpty()){ %>
         <div style= "text-align: center;font-style:italic; color:grey;">
             <%= user.getName() %> currently has no moments.
         </div>
         <% } %>
     </div>
    <hr>

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