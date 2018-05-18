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
  
  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>About the CodeU Chat App of Team Twenty-Nine</h1>
      <p>
        <strong>Team:</strong>
        <ul>
          <li>
            <strong>Bailey Pearson</strong>
            <br>
            Software Engineering @ Rochester Institute of Technology 2021
          </li>
          <li>
            <strong>James Baker</strong>
            <br>
            Mathematics and Computer Science @ Massachusetts Institute of Technology 2019
          </li>
          <li>
            <strong>Jorge Andres Sabella</strong>
            <br>
            Computer Science and Technology Engineering @ Tecnologico de Monterrey 2020
          </li>
          <li>
            <strong>Yuxin Zhu</strong>
            <br>
            Computer Science and Statistics @ Waterloo University 2021
          </li>
        </ul>
      </p>
      <p>
        <strong>Project Advisor:</strong>
        <ul>
          <li>
            Maxim Sloyko
          </li>
        </ul>
      </p>
      <p>
        CodeU Chat: A simpler way to chat
      </p>

      <ul>
        <li><strong>Admin:</strong> We've added admin capabilities to the chat.
          This allows admin to load test data and allows for extensibility in
          the code and abilities of the admin. </li>
        <li><strong>Chat Refresh:</strong> We added polling to the chat. This allows
          the chat to auto-refresh messages so the user doesn't have to refresh
          themselves.</li>
        <li><strong>Profile:</strong> We added a profile page. Each user
          can view past messages and "moments". They can also add descriptions
          to their pages.</li>
        <li><strong>Look and feel:</strong> We changed the appearence of the
          front end to make it cleaner and simpler. We also changed the color
          scheme and fonts. We also included the bootstrap library to the code
          base.</li>
      </ul>
      <br>
      <br>
    </div>
  </div>

<%@ include file = "WEB-INF/view/partials/footer.jsp" %>