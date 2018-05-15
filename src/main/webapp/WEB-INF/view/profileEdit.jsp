<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.Instant" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.Moment" %>

<% User user = (User) request.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
    <title>
        Edit My Profile Page
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

    <h1 style= "text-align: center;">My Profile Page</h1>

    <h2 style= "text-align: center;"> Edit About Me </h2>
        <form action="/profileEdit" style= "text-align: center;" method="POST">
            <input type="text" name="message" size="40" maxlength="100" placeholder="<%= user.getAbout() %>">
            <br>
            <input type="submit" value="Submit" name="submit_about">
        </form>

    <hr>
    <h2 style= "text-align: center;">Add My Moment</h2>
        <form action="/profileEdit" style= "text-align: center;" method="POST">
             <textarea name="moment" rows="8" cols=40px required></textarea>
            <br>
            <input type="text" name="location" placeholder="Where are you?">
            <input type="submit" value="Submit" name="submit_moment">
        </form>
    <hr>
</div>
<%@ include file = "partials/footer.jsp" %>