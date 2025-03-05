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

    public List<News> searchNews(String keyword, Integer airlineId, Integer status) {
        List<News> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM News WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND Title LIKE ?");
        }
        if (airlineId != null) {
            sql.append(" AND airlineId = ?");
        }
        if (status != null) {
            sql.append(" AND status = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
            }
            if (airlineId != null) {
                ps.setInt(paramIndex++, airlineId);
            }
            if (status != null) {
                ps.setInt(paramIndex++, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                News a = new News(
                        rs.getInt("NewId"), rs.getString("Title"),
                        rs.getString("img"), rs.getString("content"),
                        rs.getInt("airlineId"), rs.getInt("status")
                );
                list.add(a);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }


    public int countNews() {
        String sql = "SELECT COUNT(*) FROM News";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<News> getNewsPaginated(int start, int limit) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM News ORDER BY newId ASC LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, start);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new News(rs.getInt("newId"), rs.getString("title"),
                        rs.getInt("airlineId"), rs.getInt("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countNewsByFilter(String search, Integer status) {
        String sql = "SELECT COUNT(*) FROM News WHERE title LIKE ? ";
        if (status != null) sql += "AND status = " + status;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<News> searchNewsPaginated(String search, Integer status, int start, int limit) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM News WHERE title LIKE ? ";
        if (status != null) sql += "AND status = " + status;
        sql += " ORDER BY newId ASC LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, start);
            ps.setInt(3, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new News(rs.getInt("newId"), rs.getString("title"),
                        rs.getInt("airlineId"), rs.getInt("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public boolean updateNewsStatus(int id, int status) {
        String sql = "UPDATE News SET status = ? WHERE NewId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, status);
            stmt.setInt(2, id);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có bản ghi được cập nhật
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
