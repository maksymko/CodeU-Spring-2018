<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <%@ include file = "partials/CSS.jsp" %>
  <style>
    label {
      display: inline-block;
      width: 100px;
    }
  </style>
</head>
<body>

  <%@ include file = "partials/navbar.jsp" %>

<div id="container">
  <h1>Register</h1>

  <% if (request.getAttribute("error") != null) { %>
  <h2 class="error"><%= request.getAttribute("error") %>
  </h2>
  <% } %>

  <form action="/register" method="POST">
    <label for="username">Username: </label>
    <input type="text" name="username" id="username">
    <br/>
    <label for="password">Password: </label>
    <input type="password" name="password" id="password">
    <br/><br/>
    <p><a href="/login">Already have an account?</a></p>
    <br/>
    <button type="submit">Submit</button>
  </form>
</div>
<%@ include file = "partials/footer.jsp" %>