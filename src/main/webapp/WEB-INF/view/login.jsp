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
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <%@ include file = "partials/CSS.jsp" %>
</head>
<body>

  <%@ include file = "partials/navbar.jsp" %>

  <div id="container">
    <h1>
      <% if(request.getSession().getAttribute("user") != null){ %>
        Logout
      <% } else{ %>
        Login
      <% } %>
    </h1>

    <% if(request.getAttribute("error") != null){ %>
        <h2 class="error"><%= request.getAttribute("error") %></h2>
    <% } %>

   <% if(request.getSession().getAttribute("user") == null) {%>
    <form action="/login" method="POST">
      <label for="username">Username: </label>
      <input type="text" name="username" id="username">
      <br/>
      <label for="password">Password: </label>
      <input type="password" name="password" id="password">
      <br/><br/>
      <p><a href="/register">Don't have an account?</a></p>
      <br/>
      <button class = "btn btn-default btn-lg" type="submit" value="login" name="login">Login</button>
    </form>
   <% } else {%>
        <form action="/login" method="POST">
       <button class = "btn btn-default btn-lg" type="submit" value="logout" name="logout">Logout</button>
        </form>
   <% } %>
  </div>
<%@ include file = "partials/footer.jsp" %>