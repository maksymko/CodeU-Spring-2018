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
  <title>CodeU Chat App</title>
  <%@ include file = "WEB-INF/view/partials/CSS.jsp" %>
</head>
<body>

  <%@ include file = "WEB-INF/view/partials/navbar.jsp" %>

  <div class="background-home-div no-padding">
    <br><br><br><br><br>
    <h1 class="text-center home-h1">WELCOME</h1>
    <br><br><br>
    <h2 class="text-center home-h2">THIS IS CODEU CHAT</h2>
    <br><br>

    <div class="panel-footer row">
      <div class="col-xs-6 text-right" style="padding-right:150px; box-sizing:border-box;">
        <% if(request.getSession().getAttribute("user") != null){ %>
        <a href="/conversations" class="btn btn-default btn-lg home-btn">Get Chatting!</a>
        <% } else{ %>
        <a href="/register" class="btn btn-default btn-lg home-btn">Get Chatting!</a>
        <% } %>
      </div>
      <div class="col-xs-6 text-left" style="padding-left:150px; box-sizing:border-box;">
        <a href="/about.jsp" class="btn btn-default btn-lg home-btn">Learn More!</a>
      </div>
    </div>
    <div class="clearfix"></div>
    <br><br><br>
  </div>
<%@ include file = "WEB-INF/view/partials/footer.jsp" %>