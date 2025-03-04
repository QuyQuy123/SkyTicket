package dal;
import model.News;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO extends DBConnect{
    public News getNewsById(int id) {

        String sql = "select * from News where NewId= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                News a = new News(rs.getInt("NewId"), rs.getString("Title"),
                        rs.getString("img"), rs.getString("content"),
                        rs.getInt("airlineId"), rs.getInt("status"));
                return a;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<News> getAllNews() {
        List<News> list = new ArrayList<News>();
        String sql = "select * from News";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                News a = new News(rs.getInt("NewId"), rs.getString("Title"),
                        rs.getString("img"), rs.getString("content"),
                        rs.getInt("airlineId"), rs.getInt("status"), rs.getTimestamp("CreateAt"));
                list.add(a);
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<News> getNews() {
        List<News> list = new ArrayList<News>();
        String sql = "select * from News";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                News a = new News(rs.getInt("NewId"), rs.getString("Title"),
                        rs.getString("img"), rs.getString("content"),
                        rs.getInt("airlineId"), rs.getInt("status"));
                list.add(a);
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean addNews(News news) {
        String sql = "INSERT INTO News (title, content, img, airlineId, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getImg());
            ps.setInt(4, news.getAirlineId());
            ps.setInt(5, news.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean updateNews(News news) {
        String sql = "UPDATE News SET Title = ?, content = ?, img = ?, airlineId = ?, status = ? WHERE NewId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getImg());
            ps.setInt(4, news.getAirlineId());
            ps.setInt(5, news.getStatus());
            ps.setInt(6, news.getNewId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }



    // test

    public static void main(String[] args) {
        NewsDAO nd = new NewsDAO();
//        int id = 1;
//        System.out.println(nd.getNewsById(id));

        System.out.println(nd.getNews());
    }



}
