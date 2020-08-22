import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestServlet extends HttpServlet {

    public TestServlet() {
    }
 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        DBWorker worker = new DBWorker();

        String query = "SELECT * FROM Timetable_date";
        try {

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter context = response.getWriter();

            String date = request.getParameter("date");
            String from = request.getParameter("from");
            String to = request.getParameter("to");

            context.println("<html>");
            context.println(" <head>");
            context.println("  <meta charset=\"utf-8\">");
            context.println("  <title>Расписание вылетов</title>");
            context.println(" </head>");
            context.println("<body>");
            context.println("  <table border=\"1\">");
            context.println("   <caption><p><b><big>Расписание вылетов</big></b></p></caption>");
            context.println("   <tr><th>Дата</th><th>Время</th><th>Рейс</th><th>Авиакомпания</th><th>Город</th><th>Аэропорт</th><th>Статус</th></tr>");

            context.print("<p>\nДата: " + date + "\n</p>\n");
            context.print("<p>\nВремя с: " + from);
            context.print(" по: " + to + "\n</p>\n");

            Connection connection = worker.getConnection();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                Table table = new Table();
                table.setDate(resultSet.getDate(1));
                table.setTime(resultSet.getTime(2));
                table.setFlight(resultSet.getString(3));
                table.setAir_company(resultSet.getString(4));
                table.setCity(resultSet.getString(5));
                table.setAirport(resultSet.getString(6));
                table.setStatus(resultSet.getString(7));

                PrintWriter pw = response.getWriter();
                pw.println(table);
            }

            context.println("  </table></body></html>");
            context.println(" </body>");
            context.println("</html>");

        } catch(SQLException e) {
            throw new ServletException();
        }
 
    }
}