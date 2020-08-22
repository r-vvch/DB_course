import java.net.ConnectException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBWorker {

    private static final String URL = "jdbc:sqlserver://localhost\\SQLEXPRESS:58386;database=Airport";
    private static final String USERNAME = "test_login";
    private static final String PASSWORD = "test";

    private Connection connection;

    public DBWorker() throws ConnectException {
        try {
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            throw new ConnectException();
        }
    }

    public Connection getConnection() {
        return connection;
    }

}