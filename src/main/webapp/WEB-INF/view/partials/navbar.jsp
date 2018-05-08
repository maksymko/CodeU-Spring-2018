<!--   <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
      <a href="/profile/<%= request.getSession().getAttribute("user") %>"><%= request.getSession().getAttribute("user") %> Profile Page</a>
      <a href="/login">Logout</a>
    <% } else{ %>
      <a href="/login">Login</a>
      <a href="/register">Register</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <% if(request.getSession().getAttribute("admin") != null){ %>
      <a href="/admin">Admin</a>
    <% } %>
  </nav> -->

  <nav class="navbar navbar-inverse">
    <div class="container">
      <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-nav-demo" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
        <a href="/" class="navbar-brand">CodeU Chat App</a>
      </div>
      <div class="collapse navbar-collapse" id="bs-nav-demo">
        <ul class="nav navbar-nav">
          <li><a href="/conversations">Conversations</a></li>
          <% if(request.getSession().getAttribute("user") != null){ %>
          <li><a>Hello <%= request.getSession().getAttribute("user") %>!</a></li>
          <li><a href="/profile/<%= request.getSession().getAttribute("user") %>"><%= request.getSession().getAttribute("user") %> Profile Page</a></li>
          <% } %>
          <li><a href="/about.jsp">About</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
        <% if(request.getSession().getAttribute("user") != null){ %>
          <li><a href="/login">Logout</a></li>
        <% } else{ %>
          <li><a href="/register">Register</a></li>
          <li><a href="/login">Login</a></li>
        <% } %>
        <% if(request.getSession().getAttribute("admin") != null){ %>
          <li><a href="/admin">Admin</a></li>
        <% } %>
      </div>
      </ul>
    </div>
  </nav>
