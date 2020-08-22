import java.sql.Date;
import java.sql.Time;

public class Table {

    private Date date;
    private Time time;
    private String flight;
    private String air_company;
    private String city;
    private String airport;
    private String status;

    public Table() {
    }

    public Table(Time time, String flight, String air_company,
                 String city, String airport, String status) {
        this.date = date;
        this.time = time;
        this.flight = flight;
        this.air_company = air_company;
        this.city = city;
        this.airport = airport;
        this.status = status;
    }

    public Date getDate() { return  date; }
    public void setDate(Date date) {this.date = date; }

    public Time getTime() { return time; }
    public void setTime(Time time) { this.time = time; }

    public String getFlight() { return  flight; }
    public void setFlight(String flight) { this.flight = flight; }

    public String getAir_company() { return air_company; }
    public void setAir_company(String air_company) { this.air_company = air_company; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getAirport() { return airport; }
    public void setAirport(String airport) { this.airport = airport; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return  "<tr><td>" + date +
                "</td><td>" + time +
                "</td><td>" + flight +
                "</td><td>" + air_company +
                "</td><td>" + city +
                "</td><td>" + airport +
                "</td><td>" + status + "</td></tr>";
    }
}
