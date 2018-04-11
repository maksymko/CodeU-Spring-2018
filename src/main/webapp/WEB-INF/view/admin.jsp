<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <a href="/about.jsp">About</a>
  </nav>

  <div id="container">
    <h1>Administration</h1>
    <hr>
    <h2>Site Statistics</h2>
    <p>Here are some site stats:</p>
    <ul>
      <% if (request.getAttribute("numUsers") != null) { %>
        <li>Users: <%= request.getAttribute("numUsers") %>
        </li>
      <% } %>
      <% if (request.getAttribute("numConvos") != null) { %>
        <li>Conversations: <%= request.getAttribute("numConvos") %>
        </li>
      <% } %>
      <% if (request.getAttribute("numMessages") != null) { %>
        <li>Messages: <%= request.getAttribute("numMessages") %>
        </li>
      <% } %>
      <% if (request.getAttribute("mostActiveUser") != null) { %>
        <li>Most active user: <%= request.getAttribute("mostActiveUser") %>
        </li>
      <% } %>
      <% if (request.getAttribute("newestUser") != null) { %>
        <li>Newest user: <%= request.getAttribute("newestUser") %>
        </li>
      <% } %>
      <% if (request.getAttribute("wordiestUser") != null) { %>
        <li>Wordiest user: <%= request.getAttribute("wordiestUser") %>
        </li>
      <% } %>
    </ul>
    <hr>
    <h2>Import Data</h2>
    <form action="/admin" method="POST">
      <select name="dataType">
        <option value="RomeoJuliet">Romeo and Juliet</option>
        <option value="GreatGatsby">The Great Gatsby</option>
        <option value="MiceMen">Of Mice and Men</option>
      </select>
      <input type="submit" value="submit">
    </form>
    <hr>
  </div>
</body>
</html>
