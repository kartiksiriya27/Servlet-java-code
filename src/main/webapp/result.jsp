<!DOCTYPE html>
<html>
<head>
    <title>Success</title>
</head>
<body>
    <h1>Successfully LogIn</h1>

    <table border="1">
        <thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%= request.getAttribute("fname") %></td>
                <td><%= request.getAttribute("lname") %></td>
            </tr>
        </tbody>
    </table>
</body>
</html>
